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
