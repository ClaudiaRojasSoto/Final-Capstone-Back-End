require 'rails_helper'

RSpec.describe 'Api::Cars', type: :request do
  let!(:user1) { FactoryBot.create(:user) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
  end

  let!(:car1) { FactoryBot.create(:car, name: 'Car 1') }
  let!(:car2) { FactoryBot.create(:car, name: 'Car 2') }

  describe 'GET /api/cars' do
    it 'returns all cars' do
      get '/api/cars', headers: { 'Accept' => 'application/json' }
      expect(response).to have_http_status(:success)

      cars = JSON.parse(response.body)
      expect(cars.length).to eq(2)
    end
  end

  describe 'GET /api/cars/:id' do
    it 'returns a specific car' do
      get "/api/cars/#{car1.id}", headers: { 'Accept' => 'application/json' }
      expect(response).to have_http_status(:success)

      fetched_car = JSON.parse(response.body)['car']
      expect(fetched_car['name']).to eq('Car 1')
    end
  end

  describe 'POST /api/cars' do
    it 'creates a new car' do
      car_attributes = attributes_for(:car)
      post '/api/cars', params: { car: car_attributes }, headers: { 'Accept' => 'application/json' }
      expect(response).to have_http_status(:created)
      new_car = JSON.parse(response.body)
      expect(new_car['message']).to eq('Car created successfully')
    end
  end

  describe 'DELETE /api/cars/:id' do
    it 'deletes a specific car' do
      delete "/api/cars/#{car1.id}", headers: { 'Accept' => 'application/json' }
      expect(response).to have_http_status(:ok)

      deleted_car = JSON.parse(response.body)
      expect(deleted_car['message']).to eq('Car deleted successfully')
    end
  end
end
