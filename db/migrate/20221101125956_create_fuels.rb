class CreateFuels < ActiveRecord::Migration[7.0]
  def change
    create_table :fuels do |t|
      t.float :amount
      t.text :description
      t.integer :transaction_type
      t.references :driver, null: false, foreign_key: true

      t.timestamps
    end
  end
end
