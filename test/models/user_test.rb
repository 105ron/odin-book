require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = build(:user)
  end

  test "should be valid" do
    assert @user.valid?
  end


  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end


  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end


  test "A standard password is valid" do
    @user.password = "password"
    assert @user.valid?
  end


  test "password can't be blank" do
    @user.password = " " * 8
    assert_not @user.valid?
  end


  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@RAILS.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end


  test "email addresses should be unique" do
    @user.save
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    assert_not duplicate_user.valid?
  end


  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end


  test "users posts and comments on users post should be destroyed" do
    @user.save
    3.times do
      @post = create(:post, user_id: @user.id) 
      3.times do
        comment = create(:comment, post_id: @post.id)
      end
    end
    assert_difference 'User.count', -1 do
      assert_difference 'Post.count', -3 do
        assert_difference 'Comment.count', -9 do
          @user.destroy
        end
      end
    end
  end


  test "should create and destroy friendships" do
    rhys = create(:user)
    friend = create(:user)
    assert_not rhys.friends?(friend)
    rhys.request_friendship(friend)
    #Not yet friends without friend approving request
    assert_not rhys.friends?(friend)
    assert_not friend.friends?(rhys)
    #check only friend has a pending friendship request
    assert friend.pending_friendship?(rhys)
    assert_not rhys.pending_friendship?(friend)
    #friend accepts request
    friend.accept_friendship(rhys)
    #Now check both are friends
    assert rhys.friends?(friend)
    assert friend.friends?(rhys)
    assert_difference 'Friendship.count', -2 do
      rhys.destroy_friendship(friend)
    end
    assert_not rhys.friends?(friend)
    assert_not friend.friends?(rhys)
  end


  test "should destroy a friendship if a friend denies request" do
    rhys = create(:user)
    friend = create(:user)
    assert_not rhys.friends?(friend)
    rhys.request_friendship(friend)
    #Not yet friends without friend approving request
    assert_difference 'Friendship.count', -2 do
      friend.destroy_friendship(rhys)
    end
    assert_not rhys.friends?(friend)
    assert_not friend.friends?(rhys)
  end


  test "feed should have the right posts" do
    rhys = create(:user)
    friend = create(:user)
    #this will be most as factory posts are sequenced n.weeks ago
    rhys_recent = create(:post, user_id: rhys.id, created_at: Time.now)
    10.times do
      create(:post, user_id: rhys.id)
      create(:post, user_id: friend.id)
    end
    #Request friendship
    rhys.request_friendship(friend)
    #Make sure posts not in feed until friendship confirmed
    rhys.posts.each do |post|
      assert_not friend.feed.include?(post)
    end
    friend.posts.each do |post|
      assert_not rhys.feed.include?(post)
    end
    friend.accept_friendship(rhys)
    #make sure posts are in feed when friendship confirmed
    rhys.posts.each do |post|
      assert friend.feed.include?(post)
    end
    friend.posts.each do |post|
      assert rhys.feed.include?(post)
    end
    #Check posts are ordered by date
    assert_equal friend.feed[0], rhys_recent
  end


  test "should display friendship status for all users" do
    rhys = create(:user)
    non_friends = []
    6.times do
      non_friends << create(:user)
    end
    friend = create(:user)
    rhys.request_friendship(friend)
    friend.accept_friendship(rhys)
    assert_not rhys.users_list.include?(rhys)
    assert friend.users_list.include?(rhys)
    non_friends.each do |non_friend|
      assert rhys.users_list.include?(non_friend)
    end
    assert rhys.users_list.length == 7 #
    rhys.users_list.each do |user|
      if non_friends.include?(user)
        assert user.confirmed.nil?
      else
        assert user.confirmed == true
      end
    end
  end

end
