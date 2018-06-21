# == Schema Information
#
# Table name: objeto_types
#
#  id         :bigint(8)        not null
#  name       :string           primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ObjetoType < ApplicationRecord
  # Classe que representa o nome do Objeto
  # Todo ObjetoType pertence a um Objeto
  belongs_to :objeto

  # Todo ObjetoType tem um nome
  attr_accessor :name

  # Validar presença do atributo
  validates_presence_of :name

  self.primary_key =  "name"

  def initialize (name,valueNames, values, tipo)
    super()
    @name = name
    @rule = ObjetoRule.new()
    @rule.save
    @objeto = self.createObjeto(valueNames, values, tipo)
    @objeto.save!
    self.save!
  end

   # ObjetoType cria Objeto aplicando uma regra de criacao
  def createObjeto(valueNames, values, tipo)
      @rule.create(self,valueNames, values, tipo)
  end

   def objeto
      @objeto
   end

  def name
      @name
  end
end
