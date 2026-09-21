source "https://rubygems.org"

gem "rails", "~> 8.1.2", ">= 8.1.2.1"
gem "propshaft"
gem "pg", "~> 1.1"
gem "sqlite3", ">= 2.9.2"

gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"

gem "bcrypt", "~> 3.1.7"

gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

gem "bootsnap", require: false
gem "thruster", require: false
gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "bundler-audit", require: false
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

gem "dartsass-rails", "~> 0.5.1"
gem "json", "~> 2.10"
gem "prefixed_ids", "~> 1.8"
