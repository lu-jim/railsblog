class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    @user = User.find(params[:author_id])
    @posts = Post.where(author_id: params[:id])
  end

  def show
    @author = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def create
    @author = User.find(params[:author_id])
    @post = Post.new(post_params)
    @post.author = @author
    @post.comments = 0
    @post.likes = 0

    respond_to do |format|
      if @post.save
        format.html
        redirect_to post_url({ user_id: @author.id, id: @post.id }),
                    flash[:success] = 'Post created successfully'
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, flash: { error: 'Please make sure your post is valid' } }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:comment).permit(:text)
  end
end
