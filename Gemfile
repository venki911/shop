source 'https://rubygems.org'
ruby '2.2.1'

gem 'rails', '4.2.1'
gem 'pg'

gem 'slim-rails'
gem 'figaro'
gem 'sorcery'
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'
gem 'angular_rails_csrf'
gem 'roar-rails' # representer - extends/fits json files
gem 'jquery-rails'
# use 'carrierwave' 'master' branch to use 'mount_uploaders' - new feature currently only on this branch
gem 'carrierwave', :git => "git://github.com/carrierwaveuploader/carrierwave.git", :branch => "master"
gem 'rmagick'
gem 'fog' # Ruby cloud services library

# assets processors
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'coffee-rails-source-maps'
gem 'execjs'
gem 'ngannotate-rails'
gem 'autoprefixer-rails'
gem 'will_paginate'

# assets
source 'https://rails-assets.org' do
  gem 'rails-assets-lodash'
  gem 'rails-assets-angular', '1.3.9'
  gem 'rails-assets-angular-cache', '~> 2.3.4'
  gem 'rails-assets-angular-ui-router'
  gem 'rails-assets-angular-resource'
  gem 'rails-assets-angular-translate'
  gem 'rails-assets-angular-animate'
  gem 'rails-assets-angular-touch'
  gem 'rails-assets-angular-bootstrap'
  gem 'rails-assets-bootstrap'
  gem 'rails-assets-Font-Awesome'
  gem 'rails-assets-angular-cookies'
  gem 'rails-assets-angular-carousel'
  gem 'rails-assets-ngInfiniteScroll'
  gem 'rails-assets-ui-utils'
  gem 'rails-assets-ngDialog'
end

group :development, :test do
  gem 'spring'
  gem 'pry-rails'
  gem 'quiet_assets'
  gem 'rspec-rails'
  gem 'faker'
end

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'better_errors'
  gem "letter_opener"
end

group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
end
