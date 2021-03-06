class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @author = current_user
    @post = Post.find(params[:post_id])

    @comment = Comment.new(comment_params)
    @comment.author = @author
    @comment.post = @post

    if @comment.save
      redirect_to user_post_url({ author_id: @author.id, id: @post.id })
      flash[:success] = 'Comment created successfully'
    else
      render :new, flash: { error: 'Please make sure your post is a valid comment' }
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash.now[:success] = 'Comment deleted successfully.'
    redirect_to root_path
  end

  private

  def comment_params
    params.permit(:text)
  end
end
