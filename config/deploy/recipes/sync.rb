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
      Syncs the database and declared directories from the selected 'production' environment
      to the local development environment. This task simply calls both the 'sync:down:db' and
      'sync:down:fs' tasks.
      DESC
    task :default do
      db and fs
    end

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
    return database["#{db}"]['username'], database["#{db}"]['password'], database["#{db}"]['clients']['default']['database'], database["#{db}"]['clients']['default']['hosts'][0]
  end

  #
  # Returns the actual host name to sync and port
  #
  def host_and_port
    return roles[:web].servers.first.host, ssh_options[:port] || roles[:web].servers.first.port || 22
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
