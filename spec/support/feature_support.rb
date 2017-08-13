module FeatureSupport
  def sign_up_and_log_in
    visit '/'
    click_link 'Sign up'
    email = "user#{rand(10_000)}@example.com"
    password = 'qwertyuiop'
    sign_up(email, password)
    within 'header' do
      expect(page).to have_content("Welcome to Shine, #{email}")
    end
  end

  def log_in(email, password)
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
  end

  def sign_up(email, password)
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    click_button 'Sign up'
  end

  def get_to_mockups_page
    sign_up_and_log_in
    visit '/bootstrap_mockups'
  end
end
