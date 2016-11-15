class FriendshipsController < ApplicationController

  def create
    current_user.request_friendship(params[:id])
    redirect_to :back
  end


  def update
    current_user.accept_friendship(params[:id])v
    redirect_to :back
  end


  def destroy
    current_user.destroy_friendship(params[:id])
    redirect_to :back
  end

end
