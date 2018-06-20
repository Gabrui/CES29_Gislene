class AddPropertyRefToPropertyTypes < ActiveRecord::Migration[5.1]
  def change
    add_reference :property_types, :properties, index: true # Adicionando a referencia na tabela, property_id no property_type
  end
end
