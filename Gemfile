source 'https://rubygems.org'

# Declare your gem's dependencies in typus.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Spring!
gem 'spring'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 2.5.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.1'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0.6'

platforms :jruby do
  gem 'activerecord-jdbcmysql-adapter'
  gem 'activerecord-jdbcpostgresql-adapter'
  gem 'activerecord-jdbcsqlite3-adapter'
end

platforms :ruby do
  gem 'mysql2', '~> 0.3.15'
  gem 'pg', '~> 0.17.1'
  gem 'sqlite3', '~> 1.3.9'
end

# Typus can manage lists, trees, trashes, so we want to enable this stuff
# on the demo.
gem 'acts_as_list', :git => 'git://github.com/typus/acts_as_list.git'
gem 'acts_as_tree'
gem 'rails-permalink', '~> 1.0.0'
gem 'rails-trash', :git => 'git://github.com/fesplugas/rails-trash.git'

# We want to be able to use Factory Girl for seeding data.
gem 'factory_girl_rails', '~> 4.4.1'

# Rich Text Editor
gem 'ckeditor-rails', :git => 'git://github.com/fesplugas/rails-ckeditor.git'

# Alternative authentication
gem 'devise', :git => 'git://github.com/plataformatec/devise.git'

# Asset Management
gem 'dragonfly', '~> 1.0.3'
gem 'rack-cache', :require => 'rack/cache'
gem 'paperclip', '~> 4.1.1'

# MongoDB
gem 'mongoid', :git => 'git://github.com/mongoid/mongoid.git'

# Webserver
gem 'puma'
