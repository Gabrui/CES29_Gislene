class CreateAomTipos < ActiveRecord::Migration[5.1]
  def change
    create_table :aom_tipos do |t|

      t.timestamps
    end
  end
end
