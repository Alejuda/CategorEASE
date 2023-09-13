require 'rails_helper'

RSpec.describe 'group/index', type: :system do
  describe 'index page' do
    let!(:user) do
      User.create(name: 'nacho', email: 'nachofino98@gmail.com', password: 'nachofino1',
                  password_confirmation: 'nachofino1')
    end

    let!(:group1) do
      Group.create(author_id: user.id, name: 'Market', icon: 'https://cdn5.vectorstock.com/i/1000x1000/03/49/market-icon-flat-style-vector-13580349.jpg')
    end

    let!(:purchase1) do
      Purchase.create(author_id: user.id, name: 'Meat', amount: 500)
    end

    let!(:purchase2) do
      Purchase.create(author_id: user.id, name: 'Spagetties', amount: 350)
    end

    let!(:relation) do
      purchase1.groups << group1
      purchase2.groups << group1
    end

    before do
      sign_in user
      visit group_purchases_path(group1)
    end

    it 'displays the group info' do
      expect(page).to have_content(group1.name)

      expect(page).to have_content("TOTAL")
      expect(page).to have_content(group1.total_amount)
    end

    it 'displays the list of transactions for a group' do
      expect(page).to have_content("Transaction N° #{purchase1.id}:")
      expect(page).to have_content("Transaction N° #{purchase2.id}:")

      expect(page).to have_content(purchase1.name)
      expect(page).to have_content(purchase2.name)
      expect(page).to have_content(purchase1.amount)
      expect(page).to have_content(purchase2.amount)
    end

    it 'Display button to add new purchase' do
      expect(page).to have_content('NEW PURCHASE')
    end

    it 'The add purchase button have the correct path' do
      expect(page).to have_link('NEW PURCHASE', href: new_group_purchase_path(group1))
    end
  end
end