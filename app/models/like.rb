class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'

  after_save :update_like_counter

  def update_like_counter
    post.update(like_counter: post.likes.length)
  end
end
