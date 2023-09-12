require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.create(name: 'Nacho') }

  context 'Validation' do
    it 'should be valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'must have the name present' do
      user.name = nil
      expect(user).to_not be_valid
    end

    it 'must have a maximum name length of 100 characters' do
      user.name = 'x' * 101
      expect(user).to_not be_valid
    end

  context 'Associations' do
    it 'should have many groups' do
      association = described_class.reflect_on_association(:groups)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end
    it 'should have many purchases' do
      association = described_class.reflect_on_association(:purchases)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end
end