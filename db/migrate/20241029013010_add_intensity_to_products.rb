class AddIntensityToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :intensity, :integer

    add_index :products, :intensity
  end
end
