ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
require 'factory_girl_rails'
require "minitest/osx"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # Remove fixtures and use FactoryGirl
  #fixtures :all
  include FactoryGirl::Syntax::Methods #FactoryGirl. <- not required
  # Add more helper methods to be used by all tests here...
end
