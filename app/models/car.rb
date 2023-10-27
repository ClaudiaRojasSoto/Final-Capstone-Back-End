class Car < ApplicationRecord
  has_many :reservations, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :deposit, presence: true
  validates :finance_fee, presence: true
  validates :option_to_purchase_fee, presence: true
  validates :total_amount_payable, presence: true
  validates :duration, presence: true
  validates :removed, inclusion: { in: [true, false] }

  def available?(start_time, end_time)
    overlapping_reservations = reservations.where(
      'start_time < ? AND end_time > ?',
      end_time,
      start_time
    )
    overlapping_reservations.empty?
  end
end
