class RemoveAddressFieldsFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :street_number, :string
    remove_column :users, :street_address, :string
    remove_column :users, :state, :string
    remove_column :users, :post_code, :string
  end
end
