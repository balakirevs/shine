class AddInsightsToCustomers < ActiveRecord::Migration
  def change
  	add_column :customers, :insights, :json, default: {}
  end
end
