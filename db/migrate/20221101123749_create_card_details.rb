class CreateCardDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :card_details do |t|
      t.string :card_no
      t.string :expiry_month
      t.integer :expiry_year
      t.boolean :is_active
      t.boolean :is_default
      t.references :driver, null: false, foreign_key: true

      t.timestamps
    end
  end
end
