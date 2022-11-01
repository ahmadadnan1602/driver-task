class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.float :total_amount
      t.integer :wallet_type

      t.timestamps
    end
  end
end
