require 'rails_helper'

RSpec.describe Purchase, type: :model do
  let!(:user) do
    User.create(name: 'Nacho', email: 'nachofino98@gmail.com', password: 'nachofino1',
                password_confirmation: 'nachofino1')
  end

  let!(:purchase) do
    Purchase.create(name: 'Carne', amount: 1, author: user)
  end

  context 'Validation' do
    it 'should be valid with valid attributes' do
      expect(purchase).to be_valid
    end

    it 'must have the name present' do
      purchase.name = nil
      expect(purchase).to_not be_valid
    end

    it 'must have a maximum name length of 100 characters' do
      purchase.name = 'x' * 101
      expect(purchase).to_not be_valid
    end
  end

  it 'must include an amount greater than or equal to 0' do
    purchase.amount = nil
    expect(purchase).to_not be_valid

    purchase.amount = -1
    expect(purchase).to_not be_valid
  end

  context 'Associations' do
    it 'should belong to a user' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
    end
    it 'should have many purchases' do
      association = described_class.reflect_on_association(:groups)
      expect(association.macro).to eq(:has_and_belongs_to_many)
    end
  end
end