class CreatePropertyRules < ActiveRecord::Migration[5.1]
  def change
    create_table :property_rules do |t|

      t.timestamps
    end
  end
end
