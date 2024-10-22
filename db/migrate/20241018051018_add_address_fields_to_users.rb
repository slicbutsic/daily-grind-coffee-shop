class AddAddressFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :street_number, :string
    add_column :users, :street_address, :string
    add_column :users, :state, :string
    add_column :users, :post_code, :string
  end
end
