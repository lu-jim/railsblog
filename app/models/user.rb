class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy

  validate :name, presence: true
  validate :name, presence: true
  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
