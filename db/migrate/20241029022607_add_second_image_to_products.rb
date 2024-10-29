class AddSecondImageToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :second_image, :string
  end
end
