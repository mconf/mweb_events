source "https://rubygems.org"

# Declare your gem's dependencies in mweb_events.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"
gem 'epic-editor-rails', :git => 'https://github.com/zethussuen/epic-editor-rails.git'

gem 'devise', '~> 3.2.4'

group :test do
  gem 'faker'
  gem 'minitest'
  gem 'shoulda-matchers', '~> 2.6.1', :require => false
  gem 'populator'
end

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'
