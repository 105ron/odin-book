class LikesController < ApplicationController
  
  def create
    @post = Post.find(params[:id])
    @post.likes.build(user_id: current_user.id)
    if @post.save
      flash[:success] = "Like added to post!"
      redirect_to :back
    else
      render 'index'
    end
  end


  def destroy
    @like = Like.find_by(post_id: params[:id], user_id: current_user.id)
    if @like.destroy
      flash[:success] = "Like removed from post!"
    end
    redirect_to :back
  end

end
