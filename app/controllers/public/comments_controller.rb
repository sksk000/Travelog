class Public::CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.user_id = current_user.id
    @comment.post_id = @post.id

    if @comment.save
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = @comment.errors.full_messages.join(', ')
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
    @comment.destroy
    redirect_to post_path(@post.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment,:user_id,:post_id,:good)
  end
end
