class RemoveModeloEquipoIdFromEquipo < ActiveRecord::Migration[7.0]
  def change
    remove_reference :equipos, :modelo_equipo, null: false, foreign_key: true
  end
end
