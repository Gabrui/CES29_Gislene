class CreateTipoValues < ActiveRecord::Migration[5.1]
  def change
    create_table :tipo_values do |t|

      t.timestamps
    end
  end
end
