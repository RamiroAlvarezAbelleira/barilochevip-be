class CreateModeloEquipos < ActiveRecord::Migration[7.0]
  def change
    create_table :modelo_equipos do |t|
      t.string :name

      t.timestamps
    end
  end
end
