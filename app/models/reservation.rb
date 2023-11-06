class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates :start_time, :end_time, :city, presence: true
  validate :start_time_must_be_in_the_future

  def reservation_with_car
    {
      reservation: attributes,
      car: car.attributes
    }
  end

  private

  def start_time_must_be_in_the_future
    return if start_time.blank?
    errors.add(:start_time, "can't be in the past") if start_time < Time.current
  end
end
