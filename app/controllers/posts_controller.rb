class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.new(post_params)
    @post.user = @user
    if @post.save
      redirect_to user_post_url({ user_id: @user.id, id: @post.id })
      flash[:success] = 'Post created successfully'
    else
      render :new, flash: { error: 'Please make sure your post is valid' }
    end
  end

  private

  def post_params
    params.require(:comment).permit(:text)
  end
end
