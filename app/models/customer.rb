class Customer < ApplicationRecord
  has_many :customers_shipping_address, dependent: :destroy
  has_one :customers_billing_address, dependent: :destroy
  has_one :billing_address, through: :customers_billing_address, source: :address, dependent: :destroy

  def primary_shipping_address
    customers_shipping_address.find_by(primary: true).address
  end
end
