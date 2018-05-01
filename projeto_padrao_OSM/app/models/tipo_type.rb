class TipoType < ApplicationRecord :: Model
  
  #Classe que representa o nome de Tipo

  #Todo TipoType pertence a um Tipo
  belongs_to :tipo

  #Todo TipoType tem um name, que é uma string
  attr_acessor :name
  
  #validar se existe name
  validates_presence_of :name
  
  def initialize (name,values,valuesNames,descriptionObj,descriptionObjNames)
    super
    self.primary_key = name
    @name = name
    @rule = tipoRule.new()
    @tipo = self.createTipo(values,valuesNames,descriptionObj,descriptionObjNames)
    @tipo.save!
    self.save!
  end
   
   #TipoType sabe criar Tipo aplicando uma regra de criação
   def createTipo(values,valuesNames,descriptionObj,descriptionObjNames)
      @rule.create(self,values,valuesNames,descriptionObj,descriptionObjNames)
   end
  
   def name
      @name
   end
end
