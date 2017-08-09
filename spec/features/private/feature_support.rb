module FeatureSupport
  def sign_up_and_log_in
    visit '/'

    click_link 'Sign up'

    email = "user#{rand(10_000)}@example.com"
    password = 'qwertyuiop'

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password

    click_button 'Sign up'
  end
end
