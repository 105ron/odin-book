class FriendshipsController < ApplicationController

  def create
    current_user.request_friendship(params[:id])
    flash[:success] = "Friend request sent"
    redirect_to :back
  end


  def update
    current_user.accept_friendship(params[:id])
    flash[:success] = "Friend request accepted"
    redirect_to :back

  end


  def destroy
    @friendship = Friendship.find_by(user_id: current_user.id, friend_id: params[:id])
    @friendship.destroy
    if @friendship.confirmed
      flash[:success] = "Friendship destroyed"
    else
      flash[:success] = "Friendship request denied"
    end
    redirect_to :back
  end

end
