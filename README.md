# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration
.env file:
```
DEVISE_SECRET_KEY=
SECRET_KEY_BASE=
FACEBOOK_APP_ID=
```
* Database creation

Should create files:

### mongoid.yml

```
development:
  # Configure available database clients. (required)
  clients:
    # Defines the default client. (required)
    default:
      # Defines the name of the default database that Mongoid can connect to.
      database: blog_development
      # Provides the hosts the default client can connect to. Must be an array
      # of host:port pairs. (required)
      hosts:
        - localhost:27017
      options:
        # The name of the user for authentication.
        # user: 'user'

        # The password of the user for authentication.
        # password: 'password'

        # The user's database roles.
        # roles:
        #   - 'dbOwner'

  # Configure Mongoid specific options. (optional)
  options:

test:
  clients:
    default:
      database: blog_test
      hosts:
        - localhost:27017
      options:
        read:
          mode: :primary
        max_pool_size: 1
production:
  clients:
    default:
      database: blog_prod
      hosts:
        - localhost:27017
      options:
  options:
```

### secrets.yml

```
production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
```

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

---

# Capistrano tasks

# Environments:
  - production
  - staging

# Deploy
  `cap production deploy:initial`

  `cap production deploy`

### deploy special branch
  `BRANCH=branch_name production deploy`

### Restart server
  `cap production deploy:restart`

### Seed database
  `cap production deploy:seed`

### Reset database
  `cap production deploy:reset`

# Synchronizing databases

### Copy mongodb database from server to local environment
  `cap production sync:down:db`

### Copy static files (images) from server to local enviroment
  `cap production sync:down:fs`
  Dragon files are stored in folder /public/system/dragonfly/production for production environment and in /public/system/dragonfly/development for development environment

### Copy mongodb database from local environment to server
    `cap production sync:up:db`

### Copy static files (images) from local enviroment to server
    `cap production sync:up:fs`
