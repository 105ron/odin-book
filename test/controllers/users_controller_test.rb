require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  #Devise test helpers for sign_in and current_user
  include Devise::Test::IntegrationHelpers
	def setup
    @base_title = "Odin-Book"
    @user = create(:user)
    @user.skip_confirmation!
    sign_in @user, scope: :user
  end

  test "should get root" do
    get '/'
    assert_response :success
    assert_select "title", "Welcome | #{@base_title}"
  end

end