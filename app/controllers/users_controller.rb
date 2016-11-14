class UsersController < ApplicationController

  def index
    @users = current_user.users_list
  end

end
