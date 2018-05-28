class PropertyType < ApplicationRecord :: Model
  
  #Essa classe representa o nome da propriedade
  #Toda PropertyType percente a uma Property
  #Quando PropertyType for destruída, deve-se destruir Property
  belongs_to :property , dependent: :destroy
  
  #Toda PropertyType possui name que tipicamente é uma string
  attr_acessor :name

  #validar se name existe
  validates_presence_of :name

  def initialize (name,value)
    super

    #Criar regra de criação de Property
    @rule = PropertyRule.new()
    @property = self.createProperty(value)
    @property.save!
    self.save!
  end
   
   def createProperty(value)
       #PropertyType cria a sua Property por meio da regra de criação
      @rule.create(self,value)
   end

   def name
     @name
   end
  
end
