require 'rails_helper'

RSpec.describe 'The login process', type: :system do
  before :each do
    User.create!(id: 1, name: 'Tom', email: 'tomrails@mailinator.com',
                 photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80',
                 password: '123123', confirmed_at: Time.now)

    User.create!(id: 2, name: 'Lilly', email: 'lillyrails@mailinator.com',
                 photo: 'https://images.unsplash.com/photo-1568822617270-2c1579f8dfe2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80',
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

  it 'shows images for all users', js: true do
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80'")
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1568822617270-2c1579f8dfe2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80'")
  end

  it 'shows the number of posts for all users', js: true do
    expect(page).to have_content('Number of posts: 0')
  end

  it 'sends me to the user page when clicking them', js: true do
    click_link 'Lilly'
    expect(page).to have_content('Bio')
  end
end
