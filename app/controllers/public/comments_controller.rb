class Public::CommentsController < ApplicationController
  def create
    render json: { message: "ログインしてください", redirect_url: new_user_session_path }, status: :unprocessable_entity and return unless user_signed_in?

    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.user_id = current_user.id
    @comment.post_id = @post.id

    if @comment.save
      render json: { html: render_to_string(partial: 'public/posts/comment', layout: false, locals: { comment: @comment, user: current_user, post_id: @post.id }) }
    else
      render json: { message: "Error", errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
    if @comment.destroy
      comments = @post.comments.order(created_at: "DESC")
      render json: { html: render_to_string(partial: 'public/posts/commentindex', layout: false, locals: { comments: comments, post_id: params[:post_id] }) }
    else
      render json: { message: "コメント削除に失敗しました" }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :post_id, :good)
  end
end
