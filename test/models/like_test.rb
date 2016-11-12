require 'test_helper'

class LikeTest < ActiveSupport::TestCase

  def setup
      @like = build(:like)
  end


  test "should be valid" do
    assert @like.valid?
  end


  test "user id should be present" do
    @like.user_id = nil
    assert_not @like.valid?
  end


  test "post id should be present" do
    @like.post_id = nil
    assert_not @like.valid?
  end


  test "users posts and comments on users post should be destroyed" do
    @post = create(:post) 
    3.times do
      create(:like, post_id: @post.id)
    end
    assert_difference 'Like.count', -3 do
      @post.destroy
    end
    
  end


end
