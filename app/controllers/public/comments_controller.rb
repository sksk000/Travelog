class Public::CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @commnet = Comment.new
    @comment = Comment.new(comment_params)
    @comment.save
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
