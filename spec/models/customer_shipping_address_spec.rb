require 'rails_helper'

describe CustomersShippingAddress, type: :model do

  describe 'db' do
    context 'columns' do
      it { is_expected.to have_db_column(:primary).of_type(:boolean) }
    end
  end

  it_behaves_like 'customer billing shipping address'
end