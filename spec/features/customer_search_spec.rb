require 'rails_helper'

feature 'Customer Search' do

  let(:email)    { 'pat@example.com' }
  let(:password) { 'password123' }

  before do
    create_test_user(email: email, password: password)

    create_customer first_name: 'Chris', last_name: 'Aaron', username: 'chris'
    create_customer first_name: 'Pat', last_name: 'Johnson', username: 'patjohn'
    create_customer first_name: 'I.T.', last_name: 'Pat', username: 'patit'
    create_customer first_name: 'Patricia', last_name: 'Dobbs', username: 'patricia'

    # This user is the one we'll expect to be listed first
    create_customer first_name: 'Pat', last_name: 'Jones', username: 'pat123', email: 'pat123@somewhere.net'
  end

  scenario 'Search by Name' do
    visit '/customers'

    log_in(email, password)

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

  scenario 'Search by User Name' do
    visit '/customers'

    log_in(email, password)

    within 'section.search-form' do
      fill_in 'keywords', with: 'pat'
    end

    within 'section.search-results' do
      expect(page).to have_content('Results')
      expect(page.all('ol li.list-group-item').count).to eq(4)

      list_group_items = page.all('ol li.list-group-item')

      expect(list_group_items[0]).to have_content('patricia')
      expect(list_group_items[0]).to have_content('Dobbs')
      expect(list_group_items[3]).to have_content('patit')
      expect(list_group_items[3]).to have_content('Pat')
    end
  end

  scenario 'Search by Full Name' do
    visit '/customers'

    log_in(email, password)

    within 'section.search-form' do
      fill_in 'keywords', with: 'Patricia Dobbs'
    end

    within 'section.search-results' do
      expect(page).to have_content('Results')
      expect(page.all('ol li.list-group-item').count).to eq(1)

      list_group_items = page.all('ol li.list-group-item')

      expect(list_group_items[0]).to have_content('Patricia')
      expect(list_group_items[0]).to have_content('Dobbs')
      expect(list_group_items[3]).not_to have_content('I.T.')
      expect(list_group_items[3]).not_to have_content('Pat')
    end
  end

  scenario 'Search by Email' do
    visit '/customers'

    log_in(email, password)

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
    click_on 'View Details...', match: :first

    customer = Customer.find_by!(email: 'pat123@somewhere.net')
    within 'section.customer-details' do
      expect(page).to have_selector("[ng-reflect-model='#{customer.last_name}']")
      expect(page).to have_selector("[ng-reflect-model='#{customer.first_name}']")
      expect(page).to have_selector("[ng-reflect-model='#{customer.email}']")
      expect(page).to have_selector("[ng-reflect-model='#{customer.username}']")
    end
  end
end
