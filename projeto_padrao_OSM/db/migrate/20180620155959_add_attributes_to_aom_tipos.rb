class AddAttributesToAomTipos < ActiveRecord::Migration[5.1]
  def change
    add_column :aom_tipos, :descricao, :text
  end
end
