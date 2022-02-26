require 'rails_helper'

RSpec.describe 'Users' do
  describe 'Users pages visited', type: :feature do
    it 'Main user page is visited' do
      visit '/users'
      expect(page).to have_text('Here is a list of users')
    end

    it 'User page by ID is visited' do
      visit '/users/:5?'
      expect(page).to have_text('Here is an individual user profile')
    end
  end

  describe 'get users#show', type: :request do
    before(:each) { get '/users/:5' }

    it 'when accessing' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'get users#index', type: :request do
    before(:each) { get '/users' }

    it 'when accessing' do
      expect(response).to have_http_status(:ok)
    end
  end
end
