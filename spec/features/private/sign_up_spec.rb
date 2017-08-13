require 'rails_helper'

feature 'sign-up' do
  scenario 'we can sign up' do
    visit '/'
    expect(page).to have_content('Log in')

    click_link 'Sign up'
    screenshot! filename: 'sign-up.png'

    email = "user#{rand(10_000)}@example.com"

    sign_up(email, 'qwertyuiop')

    within 'header' do
      expect(page).to have_content("Welcome to Shine, #{email}")
    end
    within 'aside' do
      expect(page).to have_content('You have signed up successfully')
    end
    screenshot! filename: 'dashboard.png'
  end
end
