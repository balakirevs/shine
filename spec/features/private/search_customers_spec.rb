require 'rails_helper'

feature 'customers search' do
  scenario 'see the search form and sample results' do
    expiration_date = 4.years.from_now
    url = 'http://braintree.com/credit-cards/223adfasdfsd'
    allow(Faker::Business).to receive(:credit_card_number).and_return('1234567890123456')
    allow(Faker::Business).to receive(:credit_card_expiry_date).and_return(expiration_date)
    allow(Faker::Business).to receive(:credit_card_type).and_return('Maestro')
    allow(Faker::Internet).to receive(:url).and_return(url)
    sign_up_and_log_in
    5.times do |i|
      Customer.create!(
        first_name: 'Pat',
        last_name:    Faker::Name.last_name,
        username: "#{Faker::Internet.user_name}#{i}",
        email: "#{Faker::Internet.user_name}#{i}@#{Faker::Internet.domain_name}"
      ).tap do |customer|
        customer.create_customers_billing_address(address: create_address)
        customer.customers_shipping_address.create!(address: create_address,
                                                    primary: true)
      end
    end
    patricia = Customer.create!(
      first_name: 'Patricia',
      last_name:    Faker::Name.last_name,
      username: "#{Faker::Internet.user_name}99",
      email: "#{Faker::Internet.user_name}99@#{Faker::Internet.domain_name}"
    ).tap do |customer|
      customer.create_customers_billing_address(address: create_address)
      customer.customers_shipping_address.create!(address: create_address,
                                                  primary: true)
    end
    Customer.create!(
      first_name: 'Pat',
      last_name: 'Jones',
      username: "patty_#{Faker::Internet.user_name}",
      email: 'pat123@somewhere.net'
    ).tap do |customer|
      customer.create_customers_billing_address(address: create_address)
      customer.customers_shipping_address.create!(address: create_address,
                                                  primary: true)
    end
    click_link 'Customer Search'
    expect(page).to have_content('Customer Search')
    within 'section.search-form' do
      expect(page).to have_selector('input#keywords')
      fill_in 'keywords', with: 'pat'
    end
    within 'section.search-results' do
      expect(page).to have_content('Results')
      expect(page.all('ol li.list-group-item').count).to eq(7)
    end
    screenshot! filename: 'customer-search-pat.png'
    within 'section.search-form' do
      fill_in 'keywords', with: 'patricia'
      sleep 0.5
    end
    within 'section.search-results' do
      expect(page).to have_content('Results')
      expect(page.all('ol li.list-group-item').count).to eq(1)
    end
    screenshot! filename: 'customer-search-patricia.png'
    screenshot! filename: 'customer-search-component.png', selector: '.search-results ol li:first-child'
    within '.search-results ol li:first-child' do
      click_button 'View Details...'
    end
    within '.customer-details' do
      screenshot! filename: 'customer-search-details.png'
      expect(page).to have_selector("[ng-reflect-model='#{patricia.last_name}']")
      expect(page).to have_selector("[ng-reflect-model='#{patricia.first_name}']")
      expect(page).to have_selector("[ng-reflect-model='#{patricia.email}']")
      expect(page).to have_selector("[ng-reflect-model='#{patricia.username}']")
      expect(page).to have_selector("[ng-reflect-model='#{patricia.billing_address.street}']")
      expect(page).to have_selector("[ng-reflect-model='#{patricia.billing_address.city}']")
      expect(page).to have_selector("[ng-reflect-model='#{patricia.billing_address.state.code}']")
      expect(page).to have_selector("[ng-reflect-model='#{patricia.billing_address.zipcode}']")

      expect(page).to have_selector("[ng-reflect-model='#{patricia.primary_shipping_address.street}']")
      expect(page).to have_selector("[ng-reflect-model='#{patricia.primary_shipping_address.city}']")
      expect(page).to have_selector("[ng-reflect-model='#{patricia.primary_shipping_address.state.code}']")
      expect(page).to have_selector("[ng-reflect-model='#{patricia.primary_shipping_address.zipcode}']")

      screenshot! filename: 'customer-search-progress.png'
      within '.credit-card-info' do
        expect(page).to have_text('3456')
        expect(page).not_to have_text('1234567890123456')
        expect(page).not_to have_text('123456789012')
        expect(page).to have_text(expiration_date.month.to_s)
        expect(page).to have_text(expiration_date.year.to_s)
        expect(page).to have_text('Maestro')
        expect(page).to have_selector("a[href='#{url}']")
      end
      screenshot! filename: 'customer-search-done.png'
    end
  end
end
