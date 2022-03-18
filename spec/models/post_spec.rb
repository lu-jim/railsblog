require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @user = User.create(name: 'Tom',
                        photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
                        email: 'tomrails@mailinator.com',
                        password: '123123',
                        password_confirmation: '123123',
                        bio: 'Teacher from Mexico.',
                        confirmed_at: Time.now,
                        post_counter: 0)
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

  it '#recent_comments returns 5 comments' do
    subject.comments.create(post: subject, author: @user, text: 'Hi Tom! 1')
    subject.comments.create(post: subject, author: @user, text: 'Hi Tom! 2')
    subject.comments.create(post: subject, author: @user, text: 'Hi Tom! 3')
    subject.comments.create(post: subject, author: @user, text: 'Hi Tom! 4')
    subject.comments.create(post: subject, author: @user, text: 'Hi Tom! 5')
    subject.comments.create(post: subject, author: @user, text: 'Hi Tom! 6')
    expect(subject.recent_comments.length).to equal(5)
  end

  it '#recent_comments returns the latests post first' do
    subject.comments.create(post: subject, author: @user, text: 'Hi Tom! 1')
    subject.comments.create(post: subject, author: @user, text: 'Hi Tom! 2')
    expect(subject.recent_comments[0].text).to eq('Hi Tom! 2')
  end

  it '#update_post_counter updates post_counter when post is saved' do
    subject.save
    expect(@user.post_counter).to equal(1)
  end

  it 'should not save without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
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
