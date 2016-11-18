class PostsController < ApplicationController

  before_action :find_friend_requests

  def index
    @post = Post.new #to make a new post
    @posts = current_user.feed.paginate(page: params[:page]).per_page(10)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      render 'index'
    end
  end

  def show

  end


  private
  

    def post_params
      params.require(:post).permit(:content)
    end


end
