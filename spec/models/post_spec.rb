require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @user = User.create(name: 'Tom', photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80', bio: 'Teacher from Mexico.', post_counter: 0)
  end

  subject do
    @post = Post.new(
      author: @user, title: 'Hello 1', text: 'This is my first post', like_counter: 0, comment_counter: 0
    )
  end

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'should not save without a title' do
    subject.title = nil
    expect(subject).to_be false
  end

  it 'is not valid with a long title' do
    subject.title = 'Hi' * 150
    expect(subject).to_not be_valid
  end

  it 'is not valid with likes_counter negative' do
    subject.like_counter = -1
    expect(subject).to_not be_valid
  end

  it 'is not valid with likes_counter not integer' do
    subject.like_counter = 1.618
    expect(subject).to_not be_valid
  end

  it 'is not valid with comments_counter negative' do
    subject.comment_counter = -1
    expect(subject).to_not be_valid
  end

  it 'is not valid with comments_counter not integer' do
    subject.comment_counter = 3.141
    expect(subject).to_not be_valid
  end
end
