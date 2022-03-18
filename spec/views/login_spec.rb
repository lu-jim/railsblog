require 'rails_helper'

RSpec.describe 'Login page', type: :system do
  before do
    User.create(id: 1, name: 'Tom', email: 'tomrails@mailinator.com',
                password: '123123', posts_counter: 0)
  end

  describe 'Visiting the login page' do
    before :each do
      visit '/users/sign_in'
    end
end