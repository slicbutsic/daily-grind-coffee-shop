class AddImageBackToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :image, :string
  end
end
