class UsersController < ApplicationController

  def index
    @users = current_user.users_list.paginate(page: params[:page]).per_page(10)
  #current_user.users_list
  end

end
