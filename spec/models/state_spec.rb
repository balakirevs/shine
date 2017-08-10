require 'rails_helper'

describe State, type: :model do

  describe 'db' do
    context 'columns' do
      it { is_expected.to have_db_column(:code).of_type(:string) }
      it { is_expected.to have_db_column(:name).of_type(:string) }
    end
  end

  describe 'relation' do
    it { should have_many(:addresses).dependent(:destroy) }
  end
end