class UsersController < ApplicationController
  
  before_action :find_friend_requests
  before_action :check_if_friends, only: :show
  
  def index
    @users = current_user.users_list.paginate(page: params[:page]).per_page(10)
  #current_user.users_list
  end


  def show
    @post = Post.new #To create new post on current_user show page
    @posts = @user.posts.paginate(page: params[:page]).per_page(10)
  end

  private

    def check_if_friends
      @user = User.find(params[:id])
      unless current_user.friends?(@user) || current_user == @user
        flash[:error] = "Only friends of #{@user.first_name} can view this page"
        redirect_to :root
      end
    end

end
