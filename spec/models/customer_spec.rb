require 'rails_helper'

describe Customer, type: :model do

  describe 'db' do
    context 'columns' do
      it { is_expected.to have_db_column(:first_name).of_type(:string) }
      it { is_expected.to have_db_column(:last_name).of_type(:string) }
      it { is_expected.to have_db_column(:username).of_type(:string) }
      it { is_expected.to have_db_column(:email).of_type(:string) }
    end
  end

  context 'indexes' do
    it { should have_db_index(:email).unique(true) }
    it { should have_db_index(:username).unique(true) }
  end

  describe 'relation' do
    it { should have_many(:customers_shipping_address).dependent(:destroy) }
    it { should have_one(:customers_billing_address).dependent(:destroy) }
    it { should have_one(:billing_address).through(:customers_billing_address).dependent(:destroy) }
  end

  describe '.primary_shipping_address' do
    it 'returns primary shipping address' do
      customer = create_customer first_name: 'Pat', last_name: 'Jones', username: 'pat123', email: 'pat123@somewhere.net'
      expect(customer.primary_shipping_address).to eq(customer.customers_shipping_address.find_by(primary: true).address)
    end
  end
end
