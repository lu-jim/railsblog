require 'rails_helper'

RSpec.describe 'The login process', type: :system do
  before :each do
    User.create!(id: 1, name: 'Tom', email: 'tomrails@mailinator.com',
                 password: '123123', confirmed_at: Time.now)
    visit '/login'
  end

  it 'shows the username and password inputs and the "Submit" button.', js: true do
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_content('Log in')
  end

  it 'gets a detailed error if I fill in invalid data', js: true do
    fill_in 'Email', with: 'tomrails@mailinator.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content('Invalid Email or password.')
  end

  it 'logs me in with a valid input', js: true do
    within('#new_user') do
      fill_in 'Email', with: 'tomrails@mailinator.com'
      fill_in 'Password', with: '123123'
    end
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully')
  end
end
