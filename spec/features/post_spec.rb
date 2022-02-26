require 'rails_helper'

RSpec.describe 'Posts' do
  describe 'Posts pages visited', type: :feature do
    it 'Main post page is visited' do
      visit '/users/5/posts'
      expect(page).to have_text('Here is a list of comments for a given user')
    end

    it 'Post page by ID is visited' do
      visit '/users/5/posts/:8?'
      expect(page).to have_text('Here is a comment by a user')
    end
  end

  describe 'get posts#show', type: :request do
    before(:each) { get '/users/5/posts/:8' }

    it 'when accessing' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'get posts#index', type: :request do
    before(:each) { get '/users/5/posts' }

    it 'when accessing' do
      expect(response).to have_http_status(:ok)
    end
  end
end
