require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  def setup
    @post = build(:post)
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
    @post.content = "test" * 513
    assert_not @post.valid?
  end

  
  test "order should be most recent first" do
    5.times { create(:post) }
    @post = create(:post, created_at: Time.now)
    assert_equal @post, Post.first
  end


  test "post should be destroyed" do
    @post.save 
    assert_difference 'Post.count', -1 do
      @post.destroy
    end
  end


end
