class CreateEquipos < ActiveRecord::Migration[7.0]
  def change
    create_table :equipos do |t|
      t.string :name
      t.integer :price
      t.string :description
      t.integer :stock_total
      t.references :category, null: false, foreign_key: true
      t.references :modelo_equipo, null: false, foreign_key: true
      t.references :marca, null: false, foreign_key: true

      t.timestamps
    end
  end
end
