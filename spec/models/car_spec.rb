require 'rails_helper'

RSpec.describe Car, type: :model do
  subject { build(:car) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:deposit) }
  it { is_expected.to validate_presence_of(:finance_fee) }
  it { is_expected.to validate_presence_of(:option_to_purchase_fee) }
  it { is_expected.to validate_presence_of(:total_amount_payable) }
  it { is_expected.to validate_presence_of(:duration) }

  it { is_expected.to have_many(:reservations).dependent(:destroy) }
  it { is_expected.to respond_to(:image) }

  describe '#available?' do
    let(:car) { create(:car) }
    let!(:reservation) { create(:reservation, car:, start_time: Time.now + 1.hour, end_time: Time.now + 3.hours) }

    context 'when the car is available' do
      it 'returns true' do
        expect(car.available?(Time.now + 4.hours, Time.now + 6.hours)).to be_truthy
      end
    end

    context 'when the car is not available' do
      it 'returns false' do
        expect(car.available?(Time.now + 2.hours, Time.now + 4.hours)).to be_falsy
      end
    end
  end
end
