require 'rails_helper'

feature 'sign-in' do
  scenario 'homepage requires login' do
    visit '/'
    expect(page).to have_content('Log in')
    screenshot! filename: 'sign-in.png'
  end

  scenario 'we can log in' do
    visit '/'

    click_link 'Sign up'

    email = "user#{rand(10_000)}@example.com"
    password = 'qwertyuiop'

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password

    click_button 'Sign up'

    within 'header' do
      expect(page).to have_content("Welcome to Shine, #{email}")
    end

    click_link 'Log Out'

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'

    within 'header' do
      expect(page).to have_content("Welcome to Shine, #{email}")
    end
  end

  scenario 'we see an error when we fail login' do
    visit '/'
    fill_in 'Email', with: 'foo'
    fill_in 'Password', with: 'bar'
    click_button 'Log in'

    within 'aside' do
      expect(page).to have_content('Invalid Email or password')
    end
    screenshot! filename: 'sign-in-error.png'
  end
end
