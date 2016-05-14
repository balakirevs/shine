require 'rails_helper'

feature "Form Errors" do
  include SignUpAndLogin

  scenario "Form errors demo in bootstrap" do
    sign_up_and_log_in
    visit "/bootstrap_demo"
    screenshot! filename: "bootstrap-form-errors.png", selector: ".form-error"
  end
end
