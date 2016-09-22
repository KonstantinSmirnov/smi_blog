require 'yaml'
require 'pathname'


# Based on http://gist.github.com/111597 http://gist.github.com/339471
#
# Capistrano sync.rb task for syncing databases and directories between the
# local development environment and production environment
#
# Changes were made to sync MongoDB databases
# tested with mongoid
# Modified by Julius Pabrinkis

namespace :sync do

  desc <<-DESC
    Creates the sync dir in shared path. The sync directory is used to keep
    backups of database dumps and archives from synced directories. This task will
    be called on 'deploy:setup'
    DESC
  task :setup do
    on roles(:app) do
      execute "mkdir #{shared_path}/sync"
    end
  end

  namespace :down do

    desc <<-DESC
      Sync the production database to local
      DESC
    task :db do
      on roles(:db), :only => { :primary => true } do
        filename = "database.production.#{Time.now.strftime '%Y-%m-%d_%H-%M-%S'}.sql.bz2"
        username, password, database, host = remote_database_config('production')
        production_database = database

        execute "mongodump --db #{database}"
        execute "tar -cjf #{shared_path}/sync/#{filename} dump/#{database}"
        execute "rm -rf dump"
        purge_old_backups "database"

        download! "#{shared_path}/sync/#{filename}", "tmp/#{filename}"
        username, password, database = database_config('development')
        system "tar -xjvf tmp/#{filename}"

        system "mongorestore #{fetch(:db_drop, '')} --db #{database} dump/#{production_database}"

        system "rm -f tmp/#{filename} | rm -rf dump"

        logger.info "sync database from the 'production' to local finished"
      end
    end

    desc <<-DESC
      Sync the production files to local
      DESC
    task :fs do
      on roles(:web), :once => true do
        server = get_host
        port = get_port
        Array(fetch(:sync_directories, [])).each do |syncdir|
          unless File.directory? "#{syncdir}"
            logger.info "create local '#{syncdir}' folder"
            Dir.mkdir "#{syncdir}"
          end
          logger.info "sync #{syncdir} from #{server}:#{port} to local"
          destination, base = Pathname.new(syncdir).split
          system "rsync --verbose --archive --compress --copy-links --delete --stats --rsh='ssh -p #{port}' #{fetch(:user)}@#{server}:#{current_path}/#{syncdir} #{destination.to_s}"
        end

        logger.info "sync filesystem from the 'production' to local finished"
      end
    end

  end

  namespace :up do
    desc <<-DESC
      Sync the local db to production
      DESC
    task :db do
      on roles(:db), :only => { :primary => true } do
        username, password, database = database_config('development')
        dev_database = database
        filename = "database.#{database}.#{Time.now.strftime '%Y-%m-%d_%H-%M-%S'}.tar.bz2"
        system "mongodump --db #{database}"
        system "tar -cjf #{filename} dump/#{database}"

        upload! filename, "#{shared_path}/sync/#{filename}"

        system "rm -f #{filename} | rm -rf dump"

        username, password, database, host = remote_database_config('production')
        # extract to home dir
        execute "tar -xjvf #{shared_path}/sync/#{filename}"
        # clean import
        execute "mongorestore #{fetch(:db_drop, '')} --db #{database} dump/#{dev_database}"
        # remove extracted dump
        execute "rm -rf dump"

        purge_old_backups "database"

        logger.info "sync database from local to the 'production' finished"
      end
    end

    desc <<-DESC
      Sync the local files to production
      DESC
    task :fs do
      on roles(:web), :once => true do
        server = get_host
        port = get_port
          Array(fetch(:sync_directories, [])).each do |syncdir|
          destination, base = Pathname.new(syncdir).split
          if File.directory? "#{syncdir}"
            # Make a backup
            logger.info "backup #{syncdir}"
            execute "tar cjf #{shared_path}/sync/#{base}.#{Time.now.strftime '%Y-%m-%d_%H:%M:%S'}.tar.bz2 #{current_path}/#{syncdir}"
            purge_old_backups "#{base}"
          else
            logger.info "Create '#{syncdir}' directory"
            execute "mkdir #{current_path}/#{syncdir}"
          end

          # Sync directory up
          logger.info "sync #{syncdir} to #{server}:#{port} from local"
          system "rsync --verbose --archive --compress --keep-dirlinks --delete --stats --rsh='ssh -p #{port}' #{syncdir} #{fetch(:user)}@#{server}:#{current_path}/#{destination.to_s}"
        end
        logger.info "sync filesystem from local to the 'production' '#{'production'}' finished"
      end
    end
  end

  #
  # Reads the database credentials from the local config/database.yml file
  # +db+ the name of the environment to get the credentials for
  # Returns username, password, database
  #

  def database_config(db)
    database = YAML::load_file("config/#{fetch(:db_file, 'mongoid.yml')}")
    return database["#{db}"]['clients']['default']['username'], database["#{db}"]['clients']['default']['password'], database["#{db}"]['clients']['default']['database'], database["#{db}"]['clients']['default']['hosts'][0]
  end


  #
  # Reads the database credentials from the remote config/database.yml file
  # +db+ the name of the environment to get the credentials for
  # Returns username, password, database
  #
  def remote_database_config(db)
    remote_config = capture("cat #{shared_path}/config/#{fetch(:db_file, 'mongoid.yml')}")
    database = YAML::load(remote_config)
    return database["#{db}"]['clients']['default']['username'], database["#{db}"]['clients']['default']['password'], database["#{db}"]['clients']['default']['database'], database["#{db}"]['clients']['default']['hosts'][0]
  end

  #
  # Returns the actual host name to sync and port
  #
  def get_host
    roles(:web).server host
  end

  def get_port
    host.netssh_options[:port] || host.port || 22
  end

  #
  # Purge old backups within the shared sync directory
  #
  def purge_old_backups(base)
   count = fetch(:sync_backups, 5).to_i
   backup_files = capture("ls -xt #{shared_path}/sync/#{base}*").split.reverse

   if count >= backup_files.length
     logger.info "no old backups to clean up"
   else
     logger.info "keeping #{count} of #{backup_files.length} sync backups"
     delete_backups = (backup_files - backup_files.last(count)).join(" ")
     execute "rm -rf #{delete_backups}"
   end
  end

  def logger
    logger = Logger.new(STDOUT)
    logger.level = Logger::WARN
    logger
  end
end
