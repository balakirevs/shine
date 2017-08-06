describe User do
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
