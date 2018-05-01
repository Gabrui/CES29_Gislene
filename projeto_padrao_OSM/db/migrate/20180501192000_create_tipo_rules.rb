class CreateTipoRules < ActiveRecord::Migration[5.1]
  def change
    create_table :tipo_rules do |t|

      t.timestamps
    end
  end
end
