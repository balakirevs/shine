require 'rails_helper'
require 'support/violate_check_constraint_matcher'

describe User, type: :model do

  describe 'db' do
    context 'columns' do
      it { is_expected.to have_db_column(:email).of_type(:string) }
      it { is_expected.to have_db_column(:encrypted_password).of_type(:string) }
      it { is_expected.to have_db_column(:reset_password_token).of_type(:string) }
      it { is_expected.to have_db_column(:reset_password_sent_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:remember_created_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:sign_in_count).of_type(:integer) }
      it { is_expected.to have_db_column(:current_sign_in_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:last_sign_in_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:current_sign_in_ip).of_type(:inet) }
      it { is_expected.to have_db_column(:last_sign_in_ip).of_type(:inet) }
    end

    context 'indexes' do
      it { should have_db_index(:email).unique(true) }
      it { should have_db_index(:reset_password_token).unique(true) }
    end
  end

  describe 'email' do
    let(:user) do
      User.create!(email: 'foo@example.com',
                   password: 'qwertyuiop', password_confirmation: 'qwertyuiop')
    end
    it 'absolutely prevents invalid email addresses' do
      expect do
        user.update_attribute(:email, 'foo@bar.com')
      end.to violate_check_constraint(:email_must_be_company_email)
    end
  end
end
