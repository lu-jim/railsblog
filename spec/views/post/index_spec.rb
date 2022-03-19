require 'rails_helper'

RSpec.describe 'user show', type: :system do
  before :each do
    @user = User.create!(id: 1, name: 'Tom', email: 'tomrails@mailinator.com',
                         photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80',
                         password: '123123', confirmed_at: Time.now)

    @post1 = Post.create!(author: @user, title: 'Post 1', text: 'Test post 1')
    Post.create!(author: @user, title: 'Post 2', text: 'Test post 2')
    Post.create!(author: @user, title: 'Post 3', text: 'Test post 3')
    Post.create!(author: @user, title: 'Post 4', text: 'Test post 4')

    Comment.create!(author: @user, post: @post1, text: 'Test comment 1')

    visit '/login'
    within('#new_user') do
      fill_in 'Email', with: 'tomrails@mailinator.com'
      fill_in 'Password', with: '123123'
    end
    click_button 'Log in'
    visit 'users/1/posts'
  end

  it 'shows profile picture', js: true do
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80'")
  end

  it 'shows the username', js: true do
    expect(page).to have_content('Tom')
  end

  it 'shows the number of posts', js: true do
    expect(page).to have_content('Number of posts:')
  end

  it 'shows a post title', js: true do
    expect(page).to have_content('Post 4')
  end

  it 'shows a post body', js: true do
    expect(page).to have_content('Test post 4')
  end

  it 'shows the first comment of a post', js: true do
    expect(page).to have_content('Test comment 1')
  end

  it 'shows the number of comments', js: true do
    expect(page).to have_content('Comments: ')
  end

  it 'shows the number of comments', js: true do
    expect(page).to have_content('Likes: ')
  end

  it 'sends me to the user post index page when clicking see all posts', js: true do
    click_link 'Post 4'
    expect(page).to have_current_path('/users/1/posts/4')
  end
end
