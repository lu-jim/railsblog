class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments

  def latest_posts
    Post.last(3)
  end
end
