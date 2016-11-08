require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:rhys)
    @post = @user.posts.build(content: "A test post by Rhys.")
  end


  test "should be valid" do
    assert @post.valid?
  end


  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end


  test "content should be present" do
    @post.content = "   "
    assert_not @post.valid?
  end


  test "content should be at most 2048 characters" do
    @post.content = "a" * 2048
    assert @post.valid?
    @post.content = "a" * 2049
    assert_not @post.valid?
  end
  
  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end

end
