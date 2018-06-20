# == Schema Information
#
# Table name: tipos
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tipo < ApplicationRecord

  #Classe que representa a abstração Tipo

  #Todo Tipo possui um value, que geralmente é uma coleção de Property
  has_one :tipoValue
  
  #Todo Tipo possui um descriptionObjeto que é uma coleção de Property
  #descriptionObjeto são as descrições do objeto de Tipo
  has_one :description_objeto
  
  #Todo Tipo possui um TipoType
  #Quando Tipo for destruído, TipoType também é.
  has_one :tipo_type , dependent: :destroy
  
  #Tipo possui vários Objeto
  has_many :objetos

  #Validar se existem os atributos
  validates_presence_of :tipo_type, :tipoValue, :description_objeto

  def initialize(type,value,descriptionObjeto)
    super()
    @tipo_type = type
    @tipoValue = value
    @description_objeto = descriptionObjeto
    self.save
  end

  def addObjeto(objeto)
    @objetos << objeto
    self.save!
  end
   
  def has_Objeto?(objeto)
    @objeto.include?(objeto)
  end


end
