require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'should not save post without title' do
    post = Post.new
    assert_not post.save
  end

  test 'should not save post with a long title' do
    long_title = 'Hi' * 150
    post = Post.new(title: long_title, text: 'Looong title')
    assert_not post.save
  end

  test 'should throw an length error when trying a long title' do
    long_title = 'Hi' * 150
    first_user = User.create(name: 'Tom', photo: '', bio: 'Teacher from Mexico.', post_counter: 0)
    post = Post.new(author: first_user, title: long_title, text: 'Looong title', like_counter: 0, comment_counter: 0)
    assert_not post.valid?
  end
end
