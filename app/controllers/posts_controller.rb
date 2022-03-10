class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    @author = User.find(params[:user_id])
    @posts = @author.posts
  end

  def show
    @author = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def create
    @author = User.find(params[:user_id])
    @post = Post.new(post_params)
    @post.author = @author
    if @post.save
      redirect_to user_post_url({ user_id: @author.id, id: @post.id })
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
