class CreateObjetos < ActiveRecord::Migration[5.1]
  def change
    create_table :objetos do |t|

      t.timestamps
    end
  end
end
