class CreateObjetoValues < ActiveRecord::Migration[5.1]
  def change
    create_table :objeto_values do |t|

      t.timestamps
    end
  end
end
