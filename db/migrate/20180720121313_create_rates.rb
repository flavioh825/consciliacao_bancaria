class CreateRates < ActiveRecord::Migration[5.0]
  def change
    create_table :rates do |t|
      t.string :description
      t.decimal :value, precision: 8, scale: 2

      t.timestamps
    end
  end
end
