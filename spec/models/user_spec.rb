require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid with matching password and password_confirmation' do
      user = User.new(
        first_name: 'Murray',
        last_name: 'Pocha',
        email: 'murray@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to be_valid
    end

    it 'is not valid if password and confirmation do not match' do
      user = User.new(
        first_name: 'Murray',
        last_name: 'Pocha',
        email: 'murray@example.com',
        password: 'password',
        password_confirmation: 'wrong'
      )
      expect(user).to_not be_valid
    end

    it 'is not valid without a password' do
      user = User.new(
        first_name: 'Murray',
        last_name: 'Pocha',
        email: 'murray@example.com',
        password: nil,
        password_confirmation: nil
      )
      expect(user).to_not be_valid
    end

    it 'is not valid without a first name' do
      user = User.new(
        first_name: nil,
        last_name: 'Pocha',
        email: 'murray@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
    end

    it 'is not valid without a last name' do
      user = User.new(
        first_name: 'Murray',
        last_name: nil,
        email: 'murray@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
    end

    it 'is not valid without an email' do
      user = User.new(
        first_name: 'Murray',
        last_name: 'Pocha',
        email: nil,
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
    end

    it 'is not valid with a duplicate email (case insensitive)' do
      User.create!(
        first_name: 'Original',
        last_name: 'User',
        email: 'TEST@EMAIL.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user = User.new(
        first_name: 'Duplicate',
        last_name: 'User',
        email: 'test@email.COM',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
    end

    it 'is not valid if password is too short' do
      user = User.new(
        first_name: 'Murray',
        last_name: 'Pocha',
        email: 'short@pass.com',
        password: '12',
        password_confirmation: '12'
      )
      expect(user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'authenticates valid user with correct credentials' do
      user = User.create(first_name: 'Test', last_name: 'User', email: 'user@example.com', password: 'password', password_confirmation: 'password')
      result = User.authenticate_with_credentials('user@example.com', 'password')
      expect(result).to eq(user)
    end

    it 'authenticates valid user with email containing spaces' do
      user = User.create(first_name: 'Test', last_name: 'User', email: 'space@example.com', password: 'password', password_confirmation: 'password')
      result = User.authenticate_with_credentials('  space@example.com  ', 'password')
      expect(result).to eq(user)
    end

    it 'authenticates valid user with case-insensitive email' do
      user = User.create(first_name: 'Test', last_name: 'User', email: 'case@example.com', password: 'password', password_confirmation: 'password')
      result = User.authenticate_with_credentials('CaSe@ExAmPle.CoM', 'password')
      expect(result).to eq(user)
    end

    it 'returns nil with incorrect password' do
      User.create(first_name: 'Test', last_name: 'User', email: 'fail@example.com', password: 'password', password_confirmation: 'password')
      result = User.authenticate_with_credentials('fail@example.com', 'wrongpassword')
      expect(result).to be_nil
    end
  end
end