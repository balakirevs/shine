class AddBioToCustomers < ActiveRecord::Migration
  def up
    add_column :customers, :bio, :text
    execute %{
      CREATE INDEX 
        customers_bio_index ON customers 
      USING 
        gin(to_tsvector('english', bio));
    }
  end
  
  def down
    remove_column :customers, :bio
  end
end