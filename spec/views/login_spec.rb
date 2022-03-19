require 'rails_helper'

RSpec.describe 'The login process', type: :system do
  let(:user) do
    User.create(id: 1, name: 'Tom', email: 'tomrails@mailinator.com',
                password: '123123', posts_counter: 0, confirmed_at: Time.now)
  end
  before :each do
    visit '/users/sign_in'
  end

  it 'I can see the email field', js: true do
    expect(page).to have_content('Email')
  end
end
