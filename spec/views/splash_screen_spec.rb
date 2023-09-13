require 'rails_helper'

RSpec.describe 'splash_screen', type: :system do
  describe 'Splash Screen' do

    before do
      visit groups_path
    end

    it 'displays the splash screen when user not logged in' do
      expect(page).to have_content('Log in')
      expect(page).to have_content('Sign up')
    end

    it 'The login button have the correct path' do
      expect(page).to have_link('Log in', href: new_user_session_path)
    end

    it 'The sign up button have the correct path' do
      expect(page).to have_link('Sign up', href: new_user_registration_path)
    end
  end
end