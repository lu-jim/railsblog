class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])

    @like = Like.new(author: @user, post: @post)

    if Like.where(author: @user, post: @post.id).present?
      redirect_to user_post_url(author_id: @user.id, id: @post.id)
      flash[:danger] = 'Post already liked'
    else
      @like.save
      redirect_to user_post_url(author_id: @user.id, id: @post.id)
      flash[:success] = 'Post liked'
    end
  end
end
