# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |_repo| "https://github.com/#{repo}.git" }

ruby '3.2.1'

gem 'pg'
gem 'puma', '~> 6.0'
gem 'rails', '~> 7.0.8'

gem 'bootsnap', require: false
gem 'docx'
gem 'dotenv-rails'
gem 'importmap-rails'
gem 'matrix'
gem 'pdf-reader'
gem 'simple_form'
gem 'slim'
gem 'stimulus-rails'
gem 'tf-idf-similarity'
gem 'turbo-rails'

group :development, :test do
  gem 'bullet'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot'
  gem 'faker'
  gem 'rspec-rails', '~> 3.5'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'formulaic'
  gem 'guard-rspec'
  gem 'rspec-its'
  gem 'shoulda-matchers'
end
