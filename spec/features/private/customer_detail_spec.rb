require 'rails_helper'

feature "customer details" do
  include SignUpAndLogin
  given(:customer) { 
    create(:customer).tap { |customer|
      state = State.find_or_create_by!(code: "XX", name: "XX")
      CustomersBillingAddress.create!(
        customer: customer,
        address: Address.create!(street: Faker::Address.street_address,
                                 city: Faker::Address.city,
                                 state: state,
                                 zipcode: Faker::Address.zip))
      3.times do |i|
        CustomersShippingAddress.create!(
          primary: i == 0,
          customer: customer,
          address: Address.create!(street: Faker::Address.street_address,
                                   city: Faker::Address.city,
                                   state: state,
                                   zipcode: Faker::Address.zip)
        )
      end
      ActiveRecord::Base.connection.execute("REFRESH MATERIALIZED VIEW customer_details")
    }
  }

  scenario "see the basic details" do
    sign_up_and_log_in
    click_link "Customer Search"
    expect(page).to have_content("Customer Search")
    within "section.search-form" do
      expect(page).to have_selector("input[name='keywords']")
      fill_in "keywords", with: customer.first_name
    end
    expect(page).to have_selector("aside.loading-progress .not-loading")
    within "section.search-results" do
      click_button "View Details…"
    end
    within "article.panel-primary" do
      screenshot! filename: "customer-details.png"
    end
    screenshot! filename: "loading-credit-card-info.png", selector: ".billing-info"
    sleep 5
    screenshot! filename: "loaded-credit-card-info.png", selector: ".billing-info"
  end

  scenario "billing address is hidden if same as shipping" do
    customer.customers_billing_address.update_attribute(:address_id,customer.primary_shipping_address.id)
    ActiveRecord::Base.connection.execute("REFRESH MATERIALIZED VIEW customer_details")
    sign_up_and_log_in
    click_link "Customer Search"
    expect(page).to have_content("Customer Search")
    within "section.search-form" do
      expect(page).to have_selector("input[name='keywords']")
      fill_in "keywords", with: customer.first_name
    end
    expect(page).to have_selector("aside.loading-progress .not-loading")
    within "section.search-results" do
      click_button "View Details…"
    end
    within "article.panel-primary" do
      screenshot! filename: "customer-details-billing-same.png"
    end
    expect(find('input[type=checkbox]')).to be_checked
  end

  scenario "invalid fields" do
    customer.customers_billing_address.update_attribute(:address_id,customer.primary_shipping_address.id)
    ActiveRecord::Base.connection.execute("REFRESH MATERIALIZED VIEW customer_details")
    sign_up_and_log_in
    click_link "Customer Search"
    expect(page).to have_content("Customer Search")
    within "section.search-form" do
      expect(page).to have_selector("input[name='keywords']")
      fill_in "keywords", with: customer.first_name
    end
    expect(page).to have_selector("aside.loading-progress .not-loading")
    within "section.search-results" do
      click_button "View Details…"
    end
    within "article.panel-primary" do
      fill_in "email", with: "foo@bar.com"
    end
    fill_in "shippingZip", with: "aaa"
    sleep 2
    screenshot! filename: "customer-details-errors.png"
  end
end