class Public::CommentsController < ApplicationController
  def create

    unless user_signed_in?
      render json: { message: "ログインしてください", redirect_url: new_user_session_path }, status: :unprocessable_entity and return
    end

    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.user_id = current_user.id
    @comment.post_id = @post.id

    if @comment.save
      render json: { html: render_to_string(partial: 'public/posts/comment', layout: false, locals: { comment: @comment, user: current_user })}
    else
      render json: { message: "Error", errors: @comment.errors.full_messages }, status: :unprocessable_entity
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
