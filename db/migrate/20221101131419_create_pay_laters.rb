class CreatePayLaters < ActiveRecord::Migration[7.0]
  def change
    create_table :pay_laters do |t|
      t.float :total_amount
      t.boolean :is_active
      t.references :driver, null: false, foreign_key: true

      t.timestamps
    end
  end
end
