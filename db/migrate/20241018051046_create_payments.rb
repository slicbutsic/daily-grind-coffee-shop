class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.string :payment_method
      t.string :status
      t.string :transaction_id
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
    add_index :payments, :transaction_id, unique: true
  end
end
