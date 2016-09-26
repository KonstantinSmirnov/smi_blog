require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "3c9939e69fee2cc7517e755fadba8b5dcbe5c4843c7fcb5fefef75b3226f2c2d"

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly'),
    server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
