class CreateIngredientes < ActiveRecord::Migration
  def change
    create_table :ingredientes do |t|
      t.string :nombre
      t.references :measurement_units, index: true, foreign_key: true
      t.float :stock

      t.timestamps null: false
    end
  end
end
