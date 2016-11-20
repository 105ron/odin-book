class FriendshipsController < ApplicationController

  def create
    current_user.request_friendship(params[:id])
    flash[:success] = "Friend request sent"
    redirect_back(fallback_location: root_path)
  end


  def update
    current_user.accept_friendship(params[:id])
    flash[:success] = "Friend request accepted"
    redirect_back(fallback_location: root_path)

  end


  def destroy
    @friendship = Friendship.find_by(user_id: current_user.id, friend_id: params[:id])
    @friendship.destroy
    if @friendship.confirmed
      flash[:success] = "Friendship destroyed"
    else
      flash[:success] = "Friendship request denied"
    end
    redirect_back(fallback_location: root_path)
  end

end
