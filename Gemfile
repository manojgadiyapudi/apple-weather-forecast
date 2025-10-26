source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.7.8'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.3.6'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Sprockets for asset pipeline
gem 'sprockets', '~> 3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'figaro'
# Use redis for caching
gem 'redis', '~> 3.0'
gem 'redis-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  # RSpec for comprehensive testing
  gem 'rspec-rails', '~> 4.0'

  gem 'rails-controller-testing'
  # Factory Bot for test data generation
  gem 'factory_bot_rails', '~> 6.0'
  # WebMock for HTTP request stubbing
  gem 'webmock', '~> 3.0'
  # VCR for recording HTTP interactions
  gem 'vcr', '~> 6.0'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Slim templates
gem 'slim-rails', '3.4.0'

# Flash messages and authentication helpers
gem 'devise', '4.8.1'
