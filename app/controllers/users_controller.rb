class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.order(:created_at)
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.includes([:author]).order(created_at: :desc)
    @all = params[:all] unless params[:all].nil?
  end
end
