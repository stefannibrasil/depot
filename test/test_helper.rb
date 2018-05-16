ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def sample_file(filename = "bob.jpg")
    File.new("#{Rails.root}/test/fixtures/files/bob.jpg")
  end

  def login_as(user)
    post login_url, params: { username: user.username, password: 'secret' }
  end

  def logout
    delete logout_url
  end

  def setup
    login_as users(:one)
  end
end
