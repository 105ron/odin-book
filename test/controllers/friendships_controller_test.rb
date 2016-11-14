require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get only:" do
    get friendships_only:_url
    assert_response :success
  end

  test "should get :create," do
    get friendships_:create,_url
    assert_response :success
  end

  test "should get :destroy" do
    get friendships_:destroy_url
    assert_response :success
  end

end
