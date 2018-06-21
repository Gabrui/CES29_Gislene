class AddTipoRefToTipoTypes < ActiveRecord::Migration[5.1]
  def change
    add_reference :tipo_types, :tipo, index: true # Adiciona
  end
end
