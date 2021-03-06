ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  fixtures :all
  include ApplicationHelper

  BASE_TITLE = "Company Name"

  def login_as(user, options = {})
    password = options[:password] || 'password'
    remember_me = options[:remember_me] || '1'
    if integration_test?
      post login_path, params: { session: { email: user.email,
                                            password: password,
                                            remember_me: remember_me } }
    else
      session[:user_id] = user.id
      ShoppingBag.create(user: user) unless user.shopping_bag
    end
  end

  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end

  private

    def integration_test?
      defined?(follow_redirect!)
    end
end
