require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'validations' do
    it 'validates presence of name' do
      user.name = nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:name]).to include("can't be blank")
    end

    it 'validates presence of email' do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).to include("can't be blank")
    end

    it 'validates uniqueness of email' do
      create(:user, email: 'test@example.com')
      user.email = 'test@example.com'
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).to include('has already been taken')
    end

    it 'validates presence of password on create' do
      user.password = nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:password]).to include("This is a custom password can't be blank message.")
    end
  end

  describe 'associations' do
    it 'has many reservations' do
      should have_many(:reservations)
    end
  end

  describe 'password_authentication' do
    it 'authenticates with a correct password' do
      user.password = 'secure_password'
      user.save!
      expect(user.authenticate('secure_password')).to be_truthy
    end

    it 'does not authenticate with an incorrect password' do
      user.password = 'secure_password'
      user.save!
      expect(user.authenticate('wrong_password')).to be_falsey
    end
  end
end
