class CreateAomAtributos < ActiveRecord::Migration[5.1]
  def change
    create_table :aom_atributos do |t|
      t.text :nome
      t.text :descricao
      t.belongs_to :aom_tipo, foreign_key: true

      t.timestamps
    end
  end
end
