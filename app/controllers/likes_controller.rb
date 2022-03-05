class LikesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])

    @like = Like.new(author: @user, post: @post)

    if Like.where(author: @user, post: @post.id).present?
      redirect_to user_post_url(author_id: @user.id, id: @post.id)
      flash[:error] = 'Post already liked'
    else
      @like.save
      redirect_to user_post_url(author_id: @user.id, id: @post.id)
      flash[:success] = 'Post liked'
    end
  end
end
