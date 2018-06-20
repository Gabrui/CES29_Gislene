# == Schema Information
#
# Table name: property_types
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  property_id :bigint(8)
#
# Indexes
#
#  index_property_types_on_property_id  (property_id)
#

class PropertyType < ApplicationRecord
  
  #Essa classe representa o nome da propriedade
  #Toda PropertyType percente a uma Property
  #Quando PropertyType for destruída, deve-se destruir Property
  belongs_to :property , dependent: :destroy
  
  #Toda PropertyType possui name que tipicamente é uma string
  #attr_accessor :name

  #validar se name existe
  validates_presence_of :name
=begin
  def initialize (name,value)
    super()

    #Criar regra de criação de Property
    @rule = PropertyRule.new()
    self.property = self.createProperty(value)
    self.property.save
    self.save
  end
=end

  def self.criarProperty(nome, valor)
    propt = PropertyType.new
    propt.name = nome
    propt.property = PropertyRule.new().create(valor)
    propt.property.save!
    propt.save!
    return propt
  end

   def createProperty(value)
       #PropertyType cria a sua Property por meio da regra de criação
      @rule.create(value)
   end
  
end
