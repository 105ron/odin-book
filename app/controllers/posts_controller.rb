class PostsController < ApplicationController

  before_action :find_friend_requests

  def index
    @posts = current_user.feed.paginate(page: params[:page]).per_page(10)
  end

  def show

  end

  
end
