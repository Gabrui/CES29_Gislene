# == Schema Information
#
# Table name: tipo_types
#
#  id         :bigint(8)        not null
#  name       :string           primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tipo_id    :bigint(8)
#
# Indexes
#
#  index_tipo_types_on_tipo_id  (tipo_id)
#

class TipoType < ApplicationRecord
  
  #Classe que representa o nome de Tipo

  #Todo TipoType pertence a um Tipo
  belongs_to :tipo

  #Todo TipoType tem um name, que é uma string
  attr_accessor :name
  
  #validar se existe name
  validates_presence_of :name
  
  self.primary_key = "name"

  def initialize (name,values,valuesNames,descriptionObj,descriptionObjNames)
    super()
    @name = name
    @rule = TipoRule.new()
    @tipo = self.createTipo(values,valuesNames,descriptionObj,descriptionObjNames)
    @tipo.save
    self.save
  end
   
   #TipoType sabe criar Tipo aplicando uma regra de criação
   def createTipo(values,valuesNames,descriptionObj,descriptionObjNames)
      @rule.create(self,values,valuesNames,descriptionObj,descriptionObjNames)
   end
  
   def name
      @name
   end
end
