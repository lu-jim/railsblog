require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    @user = User.create(name: 'Tom',
                        email: 'tomrails@mailinator.com',
                        password: '123123',
                        password_confirmation: '123123',
                        bio: 'Teacher from Mexico.',
                        confirmed_at: Time.now,
                        post_counter: 0)
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
