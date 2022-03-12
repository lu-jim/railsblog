require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    @user = User.new(
      name: 'Tom',
      photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
      bio: 'Teacher from Mexico.',
      post_counter: 0
    )
  end

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'recent_posts returns the three posts' do
    Post.create(author: subject, title: 'Hello 1', text: 'This is my first  post', like_counter: 0, comment_counter: 0)
    Post.create(author: subject, title: 'Hello 2', text: 'This is my second  post', like_counter: 0, comment_counter: 0)
    Post.create(author: subject, title: 'Hi 3', text: 'This is my third post', like_counter: 0, comment_counter: 0)
    Post.create(author: subject, title: 'Hi 4', text: 'This is my fourth post', like_counter: 0, comment_counter: 0)
    expect(subject.recent_posts.length).to equal(3)
  end

  it 'recent_posts returns the latests post first' do
    Post.create(author: subject, title: 'Hello 1', text: 'This is my first  post', like_counter: 0, comment_counter: 0)
    Post.create(author: subject, title: 'Hello 2', text: 'This is my second  post', like_counter: 0, comment_counter: 0)
    expect(subject.recent_posts[0].title).to eq('Hello 2')
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with post_counter negative' do
    subject.post_counter = -1
    expect(subject).to_not be_valid
  end

  it 'is not valid with likes_counter not integer' do
    subject.post_counter = 1.618
    expect(subject).to_not be_valid
  end
end
