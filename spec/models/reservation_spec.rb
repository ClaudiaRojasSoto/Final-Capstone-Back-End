require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:car) }
  end

  describe 'validations' do
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:city) }
  end

  describe '#reservation_with_car' do
    let(:reservation) { create(:reservation) }

    it 'returns a hash with reservation and car attributes' do
      result = reservation.reservation_with_car
      expect(result).to have_key(:reservation)
      expect(result).to have_key(:car)
      expect(result[:reservation]).to eq(reservation.attributes)
      expect(result[:car]).to eq(reservation.car.attributes)
    end
  end
end
