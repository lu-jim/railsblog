class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250, too_long: '%<count> characters is the maximum allowed' }
  validates :like_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :comment_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  after_save :update_post_counter
  after_destroy :update_post_counter

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_post_counter
    author.update(post_counter: author.posts.length)
  end
end
