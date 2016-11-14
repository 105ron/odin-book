class UsersController < ApplicationController

  def index
    @friends = current_user.users_list
  end

end
