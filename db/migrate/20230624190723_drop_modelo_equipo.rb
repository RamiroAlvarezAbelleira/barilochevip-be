class DropModeloEquipo < ActiveRecord::Migration[7.0]
  def change
    drop_table :modelo_equipos
  end
end
