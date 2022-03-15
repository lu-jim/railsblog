class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    @user = User.find(params[:author_id])
    @posts = Post.where(author_id: params[:id]).includes(:comments)
  end

  def show
    @current_user = current_user
    @author = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def create
    @author = current_user
    @post = @author.posts.new(post_params)
    @post.comment_counter = 0
    @post.like_counter = 0

    respond_to do |format|
      if @post.save

        format.html { redirect_to user_url(@author), flash: { success: 'Post created successfully.' } }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, flash: { danger: @post.errors.messages } }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post =Post.find(params[:id])
    @post.destroy
    flash.now[:success] = 'Post deleted successfully.'
    redirect_to root_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
