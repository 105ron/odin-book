require 'test_helper'

class FriendshipsTestTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = create(:user)
    @friend = create(:user)
    @user.skip_confirmation!
    sign_in @user
  end


  test "should friend a user and unfriend" do
    get users_path
    post friendships_path, params: { id: @friend.id }
    sign_out @user
    @friend.skip_confirmation!  
    sign_in @friend
    assert_difference '@user.friends.count', 1 do
      patch friendship_path(@user.id)
    end
    sign_out @friend
    sign_in @user
    assert_difference '@user.friends.count', -1 do
      delete friendship_path(@friend.id)
    end
  end


end
