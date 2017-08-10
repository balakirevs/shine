module TestHelper
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

    customer = Customer.create!(
      first_name: first_name,
      last_name: last_name,
      username: username,
      email: email
    )
    customer.create_customers_billing_address(address: create_address)
    customer.customers_shipping_address.create!(address: create_address, primary: true)
    customer
  end

  def create_address
    state = State.find_or_create_by!(
      code: Faker::Address.state_abbr,
      name: Faker::Address.state
    )

    Address.create!(
      street: Faker::Address.street_address,
      city: Faker::Address.city,
      state: state,
      zipcode: Faker::Address.zip
    )
  end
end