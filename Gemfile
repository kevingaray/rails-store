source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'rails', '~> 6.1.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem "dockerfile-rails", ">= 1.4"
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'webdrivers'
end

gem 'tzinfo-data'
gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'devise'
gem 'faker'
gem "redis", "~> 5.0"

# to save images
gem 'aws-sdk-s3'
gem 'image_processing', '~> 1.2'

# pagination 
gem 'pagy', '~> 5.10'
# jwt
gem 'jwt'
# representer
gem 'multi_json', '~> 1.15'
gem 'representable', '~> 3.0', '>= 3.0.4'