# == Schema Information
#
# Table name: properties
#
#  id         :bigint(8)        not null, primary key
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Property < ApplicationRecord

  # Essa classe representa a propriedade de um Objeto ou Tipo
  
  # Toda propriedade (Property) tem um value, que tipicamente é uma string
  #attr_accessor :value

  # Toda propriedade (Property) tem uma PropertyType
  #Quando Property for destruído, a sua PropertyType também deve ser destruída
  has_one :property_type , dependent: :destroy
  
  #validar se as dois atributos de Property estão presentes.
  validates_presence_of :property_type , :value
=begin
  def initialize(value)
        super()
        #self.propertyType = type #associar com o PropertyType
        self.value = value       #atribuir value
        #self.save            #salvar
  end

  def name
      self.property_type.name
  end

  def value
    @value
  end

  def value=(v)
    @value = v
  end
=end
end
