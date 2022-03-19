require 'rails_helper'

RSpec.describe 'The login process', type: :system do
  before :each do
    User.create!(id: 1, name: 'Tom', email: 'tomrails@mailinator.com',
                 password: '123123', confirmed_at: Time.now)
    User.create!(id: 2, name: 'Lilly', email: 'lillyrails@mailinator.com',
                 password: 'qweqwe', confirmed_at: Time.now)
    visit '/login'
    within('#new_user') do
      fill_in 'Email', with: 'tomrails@mailinator.com'
      fill_in 'Password', with: '123123'
    end
    click_button 'Log in'
  end

  it 'shows the username of all users', js: true do
    expect(page).to have_content('Tom')
    expect(page).to have_content('Lilly')
  end
end
