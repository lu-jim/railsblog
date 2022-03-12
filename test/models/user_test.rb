require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not save user without name' do
    user = User.new
    assert_not user.save
  end

  test 'should throw an missing item error when name is empty' do
    user = User.create(photo: '', bio: 'Teacher from Mexico.', post_counter: 0)
    assert_raises('name cannot be blank') { user.save.errors }
  end
end
