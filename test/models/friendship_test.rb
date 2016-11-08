require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase

	def setup
    @rhys =  users(:rhys)
    @friend = users(:friend)
    @friendship = Friendship.create(user_id: @rhys.id, friend_id: @friend.id)
    @inverse_friendship = Friendship.find_by(user_id: @friend.id,
                                             friend_id: @rhys.id)
  end  


  test "should be valid" do
    assert @friendship.valid?
  end


  test "should require a friend_id" do
    @friendship.friend_id = nil
    assert_not @friendship.valid?
  end


  test "should require a user_id" do
    @friendship.user_id = nil
    assert_not @friendship.valid?
  end


  test "after creation friendship should be unconfirmed" do
  	assert @friendship.confirmed == false
  	assert @inverse_friendship.confirmed == false
  end


  test "Only the requestee should have a pending friend request" do
  	assert @friendship.is_pending == false
  	assert @inverse_friendship.is_pending = true
  end


  test "After confirming friendship both relations are confirmed" do
  	@inverse_friendship.confirmed = true
  	@inverse_friendship.save
  	@friendship.reload
  	assert @friendship.confirmed == true
  	assert @inverse_friendship.confirmed == true
  end


  test "After destroying friendship both relations are destroyed" do
    #destroy should delete both sides or relationship
    assert_difference 'Friendship.count', -2 do 
      @friendship.destroy
  	end
    #Double check inverse is not found and returns nil
    @inverse_friendship =Friendship.find_by(user_id: @friend.id, 
    																			 friend_id: @rhys.id)
  	assert_nil @inverse_friendship
  end


  test "Friendships can not be duplicated" do
  	@friendship = Friendship.new(user_id: @rhys.id,
                                 friend_id: @friend.id)
  	assert_not @friendship.valid?
  end

end
