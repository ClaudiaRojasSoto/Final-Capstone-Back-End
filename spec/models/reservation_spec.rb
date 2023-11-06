require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:car) }
  end

  describe 'validations' do
    subject { create(:reservation, start_time: 1.day.from_now, end_time: 2.days.from_now) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:city) }

    it 'is not valid if start_time is in the past' do
      reservation = build(:reservation, start_time: 1.day.ago, end_time: 2.days.from_now)
      expect(reservation).not_to be_valid
    end
  end

  describe '#reservation_with_car' do
    let(:user) { create(:user) }
    let(:car) { create(:car) }
    let(:reservation) { create(:reservation, user: user, car: car, start_time: 1.day.from_now, end_time: 2.days.from_now) }

    it 'returns a hash with reservation and car attributes' do
      result = reservation.reservation_with_car
      expect(result).to have_key(:reservation)
      expect(result).to have_key(:car)
      expect(result[:reservation]).to eq(reservation.attributes)
      expect(result[:car]).to eq(reservation.car.attributes)
    end
  end
end
