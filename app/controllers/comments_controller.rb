class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Post created!"
      redirect_back(fallback_location: root_path)
    else
      redirect_to :root
    end
  end

  def show

  end


  private
  

    def comment_params
      params.require(:comment).permit(:content, :post_id)
    end

end
