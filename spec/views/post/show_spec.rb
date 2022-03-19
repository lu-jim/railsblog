require 'rails_helper'

RSpec.describe 'user show', type: :system do
  before :each do
    @user = User.create!(id: 1, name: 'Tom', email: 'tomrails@mailinator.com',
                         photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80',
                         password: '123123', confirmed_at: Time.now)
    @user2 = User.create!(id: 2, name: 'Lilly', email: 'lillyrails@mailinator.com',
                          photo: 'https://images.unsplash.com/photo-1568822617270-2c1579f8dfe2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80',
                          password: 'qweqwe', confirmed_at: Time.now)
    @post = Post.create!(id: 1, author: @user, title: 'Post 1', text: 'Test post 1')
    @comment = Comment.create!(author: @user, post: @post, text: 'Test comment 1')
    @comment2 = Comment.create!(author: @user2, post: @post, text: 'Test comment 2')

    visit '/login'
    within('#new_user') do
      fill_in 'Email', with: 'tomrails@mailinator.com'
      fill_in 'Password', with: '123123'
    end
    click_button 'Log in'
    visit 'users/1/posts/1'
  end

  it 'shows the post title', js: true do
    expect(page).to have_content('Post 1')
  end

  it 'shows the post author', js: true do
    expect(page).to have_content('by Tom')
  end

  it 'shows the number of comments', js: true do
    expect(page).to have_content('Comments: ')
  end

  it 'shows the number of likes', js: true do
    expect(page).to have_content('Likes: ')
  end

  it 'shows the post body', js: true do
    expect(page).to have_content('Test post 1')
  end

  it 'shows the username of each commentor', js: true do
    expect(page).to have_content('Lilly:')
    expect(page).to have_content('Tom:')
  end

  it 'shows the comment of each commentor', js: true do
    expect(page).to have_content('Test comment 1')
    expect(page).to have_content('Test comment 2')
  end
end
