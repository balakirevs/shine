require 'rails_helper'

describe Address, type: :model do

  describe 'db' do
    context 'columns' do
      it { is_expected.to have_db_column(:street).of_type(:string) }
      it { is_expected.to have_db_column(:city).of_type(:string) }
      it { is_expected.to have_db_column(:state_id).of_type(:integer) }
      it { is_expected.to have_db_column(:zipcode).of_type(:string) }
    end
  end

  describe 'relation' do
    it { should belong_to :state }
  end
end