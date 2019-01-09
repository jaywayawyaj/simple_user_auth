require './spec/features/web_helper'

RSpec.feature 'User Authentication' do
  context 'Sign Up' do
    scenario 'A user can signup' do
      signup
      expect(page).to have_content 'You signed up successfully!'
      expect(page).to have_content 'Welcome, test@test.com'
    end

    scenario "Same email address can't be used twice" do
      signup
      signup
      expect(page).to have_content "Email or password error."
    end

    scenario "A password shorter than 6 charcters is invalid" do
      visit '/'
      click_on 'Sign up'
      fill_in :email, with: 'test@test.com'
      fill_in :password, with: 'sec23'
      click_button 'Sign up'
      expect(page).to have_content "Email or password error."
    end
  end

  context 'Sign in/out' do
    let!(:user) { User.create(email: 'test@test.com', password: 'secret123')}

    scenario 'A user can signin' do
      visit '/'
      click_on 'Sign in'
      fill_in :email, with: 'test@test.com'
      fill_in :password, with: 'secret123'
      click_button 'Sign in'

      expect(page).to have_content 'Welcome, test@test.com'
    end

    scenario 'A signed in user can log out' do
      visit '/signin'
      fill_in :email, with: 'test@test.com'
      fill_in :password, with: 'secret123'
      click_button 'Sign in'
      click_button 'Log out'

      expect(page.current_path).to eq '/'
      expect(page).to have_content 'Sign up'
      expect(page).to have_content 'Sign in'
    end
  end
end
