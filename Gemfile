source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.0.1"
gem "puma", "~> 3.0"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "jquery-rails"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "bcrypt", "~> 3.1.7"
gem "config"
gem "carrierwave"
gem "mini_magick"
gem "fog", "1.38.0"
gem "faker", "1.7.3"
gem "bootstrap-sass", "~> 3.3.6"
gem "font-awesome-rails"
gem "will_paginate", "3.1.0"
gem "bootstrap-will_paginate", "0.0.10"
gem "pry"
gem "groupdate"
gem "chartkick"
gem "jquery-turbolinks"

group :development, :test do
  gem "byebug", platform: :mri
  gem "sqlite3"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :production do
  gem "pg"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
