class User < ApplicationRecord
  has_secure_password
  has_many :reservations 

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: { message: 'This is a custom password can\'t be blank message.' }, on: :create
end
