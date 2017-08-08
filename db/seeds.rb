if Customer.all.count.zero?
  350_000.times do |i|
    Customer.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      username: "#{Faker::Internet.user_name}#{i}",
      email: Faker::Internet.user_name + i.to_s +
          "@#{Faker::Internet.domain_name}"
    )
    print '.' if (i % 1000).zero?
  end
end

State.find_or_create_by!(name: 'Alabama', code: 'AL')
State.find_or_create_by!(name: 'Alaska', code: 'AK')
State.find_or_create_by!(name: 'Arizona', code: 'AZ')
State.find_or_create_by!(name: 'Arkansas', code: 'AR')
State.find_or_create_by!(name: 'California', code: 'CA')
State.find_or_create_by!(name: 'Colorado', code: 'CO')
State.find_or_create_by!(name: 'Connecticut', code: 'CT')
State.find_or_create_by!(name: 'Delaware', code: 'DE')
State.find_or_create_by!(name: 'Dist. of Columbia', code: 'DC')
State.find_or_create_by!(name: 'Florida', code: 'FL')
State.find_or_create_by!(name: 'Georgia', code: 'GA')
State.find_or_create_by!(name: 'Hawaii', code: 'HI')
State.find_or_create_by!(name: 'Idaho', code: 'ID')
State.find_or_create_by!(name: 'Illinois', code: 'IL')
State.find_or_create_by!(name: 'Indiana', code: 'IN')
State.find_or_create_by!(name: 'Iowa', code: 'IA')
State.find_or_create_by!(name: 'Kansas', code: 'KS')
State.find_or_create_by!(name: 'Kentucky', code: 'KY')
State.find_or_create_by!(name: 'Louisiana', code: 'LA')
State.find_or_create_by!(name: 'Maine', code: 'ME')
State.find_or_create_by!(name: 'Maryland', code: 'MD')
State.find_or_create_by!(name: 'Massachusetts', code: 'MA')
State.find_or_create_by!(name: 'Michigan', code: 'MI')
State.find_or_create_by!(name: 'Minnesota', code: 'MN')
State.find_or_create_by!(name: 'Mississippi', code: 'MS')
State.find_or_create_by!(name: 'Missouri', code: 'MO')
State.find_or_create_by!(name: 'Montana', code: 'MT')
State.find_or_create_by!(name: 'Nebraska', code: 'NE')
State.find_or_create_by!(name: 'Nevada', code: 'NV')
State.find_or_create_by!(name: 'New Hampshire', code: 'NH')
State.find_or_create_by!(name: 'New Jersey', code: 'NJ')
State.find_or_create_by!(name: 'New Mexico', code: 'NM')
State.find_or_create_by!(name: 'New York', code: 'NY')
State.find_or_create_by!(name: 'North Carolina', code: 'NC')
State.find_or_create_by!(name: 'North Dakota', code: 'ND')
State.find_or_create_by!(name: 'Ohio', code: 'OH')
State.find_or_create_by!(name: 'Oklahoma', code: 'OK')
State.find_or_create_by!(name: 'Oregon', code: 'OR')
State.find_or_create_by!(name: 'Pennsylvania', code: 'PA')
State.find_or_create_by!(name: 'Rhode Island', code: 'RI')
State.find_or_create_by!(name: 'South Carolina', code: 'SC')
State.find_or_create_by!(name: 'South Dakota', code: 'SD')
State.find_or_create_by!(name: 'Tennessee', code: 'TN')
State.find_or_create_by!(name: 'Texas', code: 'TX')
State.find_or_create_by!(name: 'Utah', code: 'UT')
State.find_or_create_by!(name: 'Vermont', code: 'VT')
State.find_or_create_by!(name: 'Virginia', code: 'VA')
State.find_or_create_by!(name: 'Washington', code: 'WA')
State.find_or_create_by!(name: 'West Virginia', code: 'WV')
State.find_or_create_by!(name: 'Wisconsin', code: 'WI')
State.find_or_create_by!(name: 'Wyoming', code: 'WY')

def create_billing_address(customer_id, state)
  billing_address = Address.create!(
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    state: state,
    zipcode: Faker::Address.zip
  )
  CustomersBillingAddress.create!(customer_id: customer_id, address: billing_address)
end

def create_shipping_address(customer_id, state, is_primary)
  shipping_address = Address.create!(
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    state: state,
    zipcode: Faker::Address.zip
  )
  CustomersShippingAddress.create!(customer_id: customer_id, address: shipping_address, primary: is_primary)
end

all_states = State.all.to_a

Customer.find_each do |customer|
  next if customer.customers_shipping_address.any?
  puts "Creating addresses for #{customer.id}..."
  create_billing_address(customer.id, all_states.sample)
  num_shipping_addresses = rand(4) + 1
  num_shipping_addresses.times do |i|
    create_shipping_address(customer.id, all_states.sample, i.zero?)
  end
end
