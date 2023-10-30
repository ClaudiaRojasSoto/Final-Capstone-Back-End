class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_secure_password
  has_many :reservations

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: { message: 'This is a custom password can\'t be blank message.' }, on: :create
end
