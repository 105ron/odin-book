require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  def setup
    @post = posts(:most_recent)
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


  test "post should be destroyed" do
    assert_difference 'Post.count', -1 do
      @post.destroy
    end
  end

  test "associated comments should be destroyed" do
    assert_difference 'Comment.count', -2 do
      #two comments for post in fxtures
      @post.destroy
    end
  end

end
