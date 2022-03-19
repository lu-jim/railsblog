class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.order(:created_at)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.recent_posts.includes([:author]).order(created_at: :desc)
  end
end
