class CreateObjetoRules < ActiveRecord::Migration[5.1]
  def change
    create_table :objeto_rules do |t|

      t.timestamps
    end
  end
end
