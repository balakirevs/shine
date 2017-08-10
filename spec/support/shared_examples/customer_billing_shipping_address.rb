shared_examples 'customer billing shipping address' do
  describe 'db' do
    context 'columns' do
      it { is_expected.to have_db_column(:customer_id).of_type(:integer) }
      it { is_expected.to have_db_column(:address_id).of_type(:integer) }
    end
  end

  describe 'relation' do
    it { should belong_to(:address) }
    it { should belong_to(:customer) }
  end
end
