require 'rails_helper'

feature 'Customer Search' do
  def create_test_user(email:, password:)
    User.create!(
      email: email,
      password: password,
      password_confirmation: password
    )
  end

  def create_customer(first_name:, last_name:, email: nil)
    username = "#{Faker::Internet.user_name}#{rand(1000)}"
    email  ||= "#{username}#{rand(1000)}@#{Faker::Internet.domain_name}"

    Customer.create!(
      first_name: first_name,
      last_name: last_name,
      username: username,
      email: email
    )
  end

  let(:email)    { 'pat@example.com' }
  let(:password) { 'password123' }

  before do
    create_test_user(email: email, password: password)

    create_customer first_name: 'Chris', last_name: 'Aaron'
    create_customer first_name: 'Pat', last_name: 'Johnson'
    create_customer first_name: 'I.T.', last_name: 'Pat'
    create_customer first_name: 'Patricia', last_name: 'Dobbs'

    # This user is the one we'll expect to be listed first
    create_customer first_name: 'Pat',
                    last_name: 'Jones',
                    email: 'pat123@somewhere.net'
  end

  scenario 'Search by Name' do
    visit '/customers'

    # Login to get access to /customers
    fill_in 'Email',    with: email
    fill_in 'Password', with: password
    click_button 'Log in'

    within 'section.search-form' do
      fill_in 'keywords', with: 'pat'
    end

    within 'section.search-results' do
      expect(page).to have_content('Results')
      expect(page.all('ol li.list-group-item').count).to eq(4)

      list_group_items = page.all('ol li.list-group-item')

      expect(list_group_items[0]).to have_content('Patricia')
      expect(list_group_items[0]).to have_content('Dobbs')
      expect(list_group_items[3]).to have_content('I.T.')
      expect(list_group_items[3]).to have_content('Pat')
    end
  end

  scenario 'Search by Email' do
    visit '/customers'

    # Login to get access to /customers
    fill_in 'Email',    with: email
    fill_in 'Password', with: password
    click_button 'Log in'

    within 'section.search-form' do
      fill_in 'keywords', with: 'pat123@somewhere.net'
    end
    within 'section.search-results' do
      expect(page).to have_content('Results')
      expect(page.all('ol li.list-group-item').count).to eq(4)

      list_group_items = page.all('ol li.list-group-item')

      expect(list_group_items[0]).to have_content('Pat')
      expect(list_group_items[0]).to have_content('Jones')
      expect(list_group_items[1]).to have_content('Patricia')
      expect(list_group_items[1]).to have_content('Dobbs')
      expect(list_group_items[3]).to have_content('I.T.')
      expect(list_group_items[3]).to have_content('Pat')
    end
  end
end
