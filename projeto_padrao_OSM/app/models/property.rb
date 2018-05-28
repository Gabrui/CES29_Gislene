class Property < ApplicationRecord :: Model

  # Essa classe representa a propriedade de um Objeto ou Tipo
  
  # Toda propriedade (Property) tem um value, que tipicamente é uma string
  attr_accessor :value

  # Toda propriedade (Property) tem uma PropertyType
  #Quando Property for destruído, a sua PropertyType também deve ser destruída
  has_one :propertyType , dependent: :destroy
  
  #validar se as dois atributos de Property estão presentes.
  validates_presence_of :propertyType , :value

  def initialize(type,value)
        super
        @propertyType = type #associar com o PropertyType
        @value = value       #atribuir value
        self.save!               #salvar
  end

  def name
      @propertyType.name
  end

  def value
    @value
  end

end
