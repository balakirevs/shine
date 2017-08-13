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

    sign_up(email, password)

    within 'header' do
      expect(page).to have_content("Welcome to Shine, #{email}")
    end

    click_link 'Log Out'

    log_in(email, password)

    within 'header' do
      expect(page).to have_content("Welcome to Shine, #{email}")
    end
  end

  scenario 'we see an error when we fail login' do
    visit '/'
    log_in('foo', 'bar')

    within 'aside' do
      expect(page).to have_content('Invalid Email or password')
    end
    screenshot! filename: 'sign-in-error.png'
  end
end
