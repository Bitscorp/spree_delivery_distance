source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'geocoder'

gem 'spree', github: 'spree/spree', branch: 'master'

group :test do
  gem 'sqlite3'

  gem 'rails-controller-testing'

  gem 'database_cleaner'
  gem 'factory_bot'

  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-stack_explorer', '~> 0.5.0'

  gem 'rspec'
  gem 'rspec-rails'
end

gemspec
