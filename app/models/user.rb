class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments

  def latest_posts
    Post.where('author_id=?', params[:author_id]).order(:created_at).last(3)
  end
end
