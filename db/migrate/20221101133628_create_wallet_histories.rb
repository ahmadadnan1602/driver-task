class CreateWalletHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :wallet_histories do |t|
      t.integer :wallet_id
      t.float :total_amount
      t.string :transaction_histories_ids
      t.references :driver, :card_detail, null: false, foreign_key: true

      t.timestamps
    end
    add_index :wallet_histories, :wallet_id
  end
end
