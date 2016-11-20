require 'test_helper'

class PostsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @post = create(:post)
    @user = @post.user
    @user.skip_confirmation!
    sign_in @user
  end


  test "user can create posts" do
    get posts_path
    assert_difference '@user.posts.count', 1 do
      post posts_path(@user), params: { post: {content: "here is a test post" } }
    end
  end

  test "user can like and unlike their own posts" do
    assert_difference '@post.likes.count', 1 do
      post likes_path(:id => @post.id)   
    end
    assert_difference '@post.likes.count', -1 do
      delete like_path(@post)   
    end
  end


  test "user can like and unlike their others posts" do
    @new_post = create(:post)
    assert_difference '@new_post.likes.count', 1 do
      post likes_path(:id => @new_post.id)   
    end
    assert_difference '@new_post.likes.count', -1 do
      delete like_path(@new_post)   
    end
  end

  test "user can comment on their posts" do
    assert_difference '@post.comments.count', 1 do
      post comments_path(@user), params: { comment: {content: "Here is a comment on the post",
                                                     post_id: @post.id } }
    end
  end


  test "user can comment on others posts" do
    @new_post = create(:post)
    assert_difference '@new_post.comments.count', 1 do
      post comments_path(@user), params: { comment: {content: "Here is a comment on the post",
                                                     post_id: @new_post.id } }
    end
  end



end
