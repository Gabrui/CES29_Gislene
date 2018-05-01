class CreateDescriptionObjetos < ActiveRecord::Migration[5.1]
  def change
    create_table :description_objetos do |t|

      t.timestamps
    end
  end
end
