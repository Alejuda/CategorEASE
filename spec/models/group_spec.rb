require 'rails_helper'

RSpec.describe Group, type: :model do
  let!(:user) do
    User.create(name: 'Nacho', email: 'nachofino98@gmail.com', password: 'nachofino1',
                password_confirmation: 'nachofino1')
  end

  let!(:group) do
    Group.create(name: 'Supermarket', icon: "https://icons.com", author: user)
  end

  context 'Validation' do
    it 'should be valid with valid attributes' do
      expect(group).to be_valid
    end

    it 'must have the name present' do
      group.name = nil
      expect(group).to_not be_valid
    end

    it 'must have a maximum name length of 100 characters' do
      group.name = 'x' * 101
      expect(group).to_not be_valid
    end

    it 'must include an icon' do
      group.icon = nil
      expect(group).to_not be_valid
    end
  end

  context 'Associations' do
    it 'should belong to a user' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
    end
    it 'should have many purchases' do
      association = described_class.reflect_on_association(:purchases)
      expect(association.macro).to eq(:has_and_belongs_to_many)
    end
  end
end