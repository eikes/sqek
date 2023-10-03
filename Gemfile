source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Terser as compressor for JavaScript assets
gem 'terser'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Added gems
gem 'devise'
gem 'cancancan'

gem 'bootstrap-sass', '~> 3.4.0'
gem 'haml-rails'
gem 'autoprefixer-rails'
gem 'tinymce-rails'
gem 'simple_form'
gem 'leaflet-rails'
gem 'friendly_id'
gem 'nested_form'
gem 'paper_trail'

gem 'rails-i18n', '~> 6.0'
gem 'devise-i18n'
gem 'devise-i18n-views'

gem 'carrierwave'
gem 'mini_magick'
gem 'select2-rails'
gem 'rails_autolink'

# Export XLSX files
gem 'caxlsx'
gem 'caxlsx_rails'

gem 'premailer-rails'
gem 'nokogiri'

gem 'rb-readline'

source 'https://rails-assets.org/' do
  gem 'rails-assets-lightbox', '~> 2.7.4'
end

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
group :development do
  gem 'listen'
  gem 'awesome_print', require: 'ap'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
end

group :development, :test do
  gem 'debug'
  gem 'webrick'

  gem 'rails-controller-testing'
end

group :production do
  # Use MySQL as the database for Active Record
  gem 'mysql2'
  # Use Passenger as the app server
  gem 'passenger'
end

