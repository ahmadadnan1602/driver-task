class CreateTransactionHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :transaction_histories do |t|
      t.float :amount
      t.string :transaction_type
      t.boolean :is_settle, default: false
      t.references :transactiontable, polymorphic: true, null: false
      t.references :driver, null: false, foreign_key: true
      t.timestamps
    end
 
  end
end
