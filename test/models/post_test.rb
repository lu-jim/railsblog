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
    post = Post.new(title: long_title, text: 'Looong title')
    assert_raises('250 characters is the maximum allowed') { post.save.errors }
  end
end
