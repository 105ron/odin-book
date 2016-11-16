require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  #Devise test helpers for sign_in and current_user
  include Devise::Test::IntegrationHelpers
	
  def setup
    @base_title = "Odin-Book"
    @user = create(:user)
    @user.skip_confirmation!
    sign_in @user
  end

  test "should get root" do
    sign_out @user
    get '/'
    assert_response :redirect
    assert_redirected_to new_user_session_url
  end

  test "Pending friend requests should appear in navigation bar" do
    get users_url
    assert_response :success
    assert_select "a", :href => /\/friendships\/\d{1,8}/, text: "Accept", count: 0
    @friend = create(:user)
    @friend.request_friendship(@user.id)
    get users_url
    assert_select "a", :href => /\/friendships\/\d{1,8}/, text: "Accept", count: 1
    #The link should also be displayed in the users list too.
    assert_select "a", :href => /\/friendships\/\d{1,8}/, text: "Cancel?", count: 1
  end
end