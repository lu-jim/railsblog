class UsersController < ApplicationController
  def index
    @users = User.all.order(:created_at)
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(author_id: params[:id])
    @all = params[:all] unless params[:all].nil?
  end
end
