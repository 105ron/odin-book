require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def setup
    @comment = comments(:comments_rhys)
  end


  test "should be valid" do
    assert @comment.valid?
  end


  test "user id should be present" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end


  test "post id should be present" do
    @comment.post_id = nil
    assert_not @comment.valid?
  end


  test "content should be present" do
    @comment.content = "   "
    assert_not @comment.valid?
  end


  test "content should be at most 2048 characters" do
    @comment.content = "a" * 1024
    assert @comment.valid?
    @comment.content = "a" * 1025
    assert_not @comment.valid?
  end

  
  test "order should be most recent first" do
    assert_equal @comment, Comment.first
  end

end
