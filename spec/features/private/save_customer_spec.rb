require 'rails_helper'

feature 'search' do
  let(:customer_attributes) do
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      username: Faker::Internet.user_name + rand(1000).to_s
    }
  end
  let!(:customer) do
    Customer.create!(customer_attributes).tap do |c|
      c.create_customers_billing_address(address: create_address)
      c.customers_shipping_address.create!(address: create_address,
                                           primary: true)
    end
  end

  scenario 'navigate' do
    sign_up_and_log_in
    visit '/customers'
    fill_in 'keywords', with: customer.email
    within '.search-results ol' do
      click_on('View Details...', match: :first)
    end
    within '.customer-details' do
      fill_in 'first_name', with: ''
      within 'aside.alert' do
        expect(page).to have_text('This is required')
      end
    end
    screenshot! filename: 'validation-required.png'
    fill_in 'first_name', with: 'Pat'
    within '.customer-details .Shipping' do
      fill_in 'zipcode', with: 'abcde'
      within 'aside.alert' do
        expect(page).to have_text('This is not a Zip Code')
      end
      fill_in 'state', with: ''
      fill_in 'city', with: ''
    end
    screenshot! filename: 'address-validation-better.png'
    within '.customer-details .Shipping' do
      fill_in 'state', with: 'DC'
      fill_in 'city', with: 'Washington'
      fill_in 'zipcode', with: '12345'
      expect(page).not_to have_text('This is not a Zip Code')
      fill_in 'zipcode', with: '12345-1234-1234'
      within 'aside.alert' do
        expect(page).to have_text('This is not a Zip Code')
      end
    end
  end
end
