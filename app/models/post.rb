class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  after_save :update_post_counter

  def recent_comments
    comments.order(created_at: :desc).limit(3)
  end

  private

  def update_post_counter
    author.update(post_counter: author.posts.length)
  end
end
