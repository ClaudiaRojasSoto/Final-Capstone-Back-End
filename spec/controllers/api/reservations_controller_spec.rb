require 'rails_helper'

RSpec.describe 'Api::Reservations', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:car) { FactoryBot.create(:car) }
  let!(:reservation) { FactoryBot.create(:reservation, user:, car:) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe 'GET /api/user_reservations' do
    it 'returns all reservations' do
      get '/api/user_reservations', headers: { 'Accept' => 'application/json' }
      expect(response).to have_http_status(:success)
      reservations = JSON.parse(response.body)
      expect(reservations.length).to eq(1)
    end
  end

  describe 'GET /api/reservations/:id' do
    it 'returns a specific reservation' do
      get "/api/reservations/#{reservation.id}", headers: { 'Accept' => 'application/json' }
      expect(response).to have_http_status(:success)
      fetched_reservation = JSON.parse(response.body)
      expect(fetched_reservation['id']).to eq(reservation.id)
    end
  end

  describe 'POST /api/cars/:car_id/reservations' do
    it 'creates a new reservation' do
      car = create(:car, :available)
      reservation_attributes = attributes_for(:reservation)
      post "/api/cars/#{car.id}/reservations", params: { reservation: reservation_attributes },
                                               headers: { 'Accept' => 'application/json' }

      expect(response).to have_http_status(:success)
      new_reservation = JSON.parse(response.body)
      expect(new_reservation['success']).to eq(true)
    end
  end

  describe 'PUT /api/reservations/:id' do
    it 'updates a specific reservation' do
      put "/api/reservations/#{reservation.id}", params: { reservation: { city: 'New City' } },
                                                 headers: { 'Accept' => 'application/json' }
      expect(response).to have_http_status(:success)
      updated_reservation = Reservation.find(reservation.id)
      expect(updated_reservation.city).to eq('New City')
    end
  end

  describe 'DELETE /api/reservations/:id' do
    it 'deletes a specific reservation' do
      expect do
        delete "/api/reservations/#{reservation.id}", headers: { 'Accept' => 'application/json' }
      end.to change(Reservation, :count).by(-1)
      expect(response).to have_http_status(:success)
    end
  end
end
