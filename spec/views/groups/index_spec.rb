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

    let!(:group2) do
      Group.create(author_id: user.id, name: 'Hobbies', icon: 'https://th.bing.com/th/id/OIP.ml8sJvEtDiWO5X4VmcpuzgAAAA?pid=ImgDet&rs=1')
    end

    before do
      sign_in user
      visit groups_path
    end

    it 'displays the list of groups' do
      expect(page).to have_content('GROUPS')

      expect(page).to have_content(group1.name)
      expect(page).to have_content(group2.name)
      expect(page).to have_content(group1.total_amount)
      expect(page).to have_content(group2.total_amount)
    end

    it 'Display button to add new category' do
      expect(page).to have_content('ADD NEW CATEGORY')
    end

    it 'The add category button have the correct path' do
      expect(page).to have_link('ADD NEW CATEGORY', href: new_group_path)
    end
  end
end