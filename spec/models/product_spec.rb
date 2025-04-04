require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.new(name: 'Test Category')
    end

    it 'is valid with all fields present' do
      product = Product.new(
        name: 'Plant',
        price_cents: 2500,
        quantity: 5,
        category: @category
      )
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      product = Product.new(
        name: nil,
        price_cents: 2500,
        quantity: 5,
        category: @category
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not valid without a price' do
      product = Product.new(
        name: 'Plant',
        price_cents: nil,
        quantity: 5,
        category: @category
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'is not valid without a quantity' do
      product = Product.new(
        name: 'Plant',
        price_cents: 2500,
        quantity: nil,
        category: @category
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'is not valid without a category' do
      product = Product.new(
        name: 'Plant',
        price_cents: 2500,
        quantity: 5,
        category: nil
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
