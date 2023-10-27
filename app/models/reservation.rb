class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates :start_time, :end_time, :city, presence: true

  def reservation_with_car
    {
      reservation: self.attributes,
      car: self.car.attributes
    }
  end
end
