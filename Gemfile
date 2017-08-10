source 'https://rubygems.org'

ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'angular_rails_csrf'
gem 'brakeman'
gem 'coffee-rails', '~> 4.2'
gem 'devise', '~> 4.3'
gem 'faker'
gem 'foreman', '~> 0.84'
gem 'jbuilder', '~> 2.5'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 2.0'

group :development, :test do
  gem 'database_cleaner'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'poltergeist'
  gem 'rspec-rails', '~> 3.4'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
