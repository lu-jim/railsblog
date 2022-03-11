class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'

  after_save :update_comment_counter

  private

  def update_comment_counter
    post.update(comment_counter: post.comments.count('id'))
  end
end
