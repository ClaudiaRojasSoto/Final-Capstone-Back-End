require 'rails_helper'

RSpec.describe 'Api::Users', type: :request do
  let!(:user1) { FactoryBot.create(:user, name: 'John Doe', email: 'john@example.com', password: 'password') }
  let!(:user2) { FactoryBot.create(:user, name: 'Jane Doe', email: 'jane@example.com', password: 'password') }

  describe 'GET /api/users' do
    it 'returns all users' do
      get '/api/users', headers: { 'Accept' => 'application/json' }
      expect(response).to have_http_status(:success)

      users = JSON.parse(response.body)
      expect(users.length).to eq(2)
    end
  end

  describe 'GET /api/users/:id' do
    it 'returns a specific user' do
      get "/api/users/#{user1.id}", headers: { 'Accept' => 'application/json' }
      expect(response).to have_http_status(:success)

      fetched_user = JSON.parse(response.body)
      expect(fetched_user['name']).to eq('John Doe')
    end
  end

  describe 'POST /api/users' do
    it 'creates a new user' do
      post '/api/users', params: { user: { name: 'New User', email: 'new@example.com', password: 'password' } },
                         headers: { 'Accept' => 'application/json' }
      expect(response).to have_http_status(:created)

      new_user = JSON.parse(response.body)
      expect(new_user['success']).to eq(true)
      expect(new_user['message']).to eq('Sign in was successful!')
    end
  end
end
