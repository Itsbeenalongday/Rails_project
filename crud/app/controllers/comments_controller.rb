class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  def create
    comment = Comment.create(comment_params)
    comment.post_id = params[:post_id]
    comment.user_id = current_user.id
    comment.save
    redirect_to post_path(params[:post_id])
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
