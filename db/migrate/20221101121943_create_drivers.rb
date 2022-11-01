class CreateDrivers < ActiveRecord::Migration[7.0]
  def change
    create_table :drivers do |t|
      t.string :name
      t.text :address
      t.string :licence_number
      t.datetime :d_o_b
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
