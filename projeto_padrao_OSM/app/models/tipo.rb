class Tipo < ApplicationRecord :: Model

  #Classe que representa a abstração Tipo

  #Todo Tipo possui um value, que geralmente é uma coleção de Property
  has_one :TipoValues 
  
  #Todo Tipo possui um descriptionObjeto que é uma coleção de Property
  #descriptionObjeto são as descrições do objeto de Tipo
  has_one :descriptionObjetos
  
  #Todo Tipo possui um TipoType
  #Quando Tipo for destruído, TipoType também é.
  has_one :tipoType , dependent: :destroy
  
  #Tipo possui vários Objeto
  has_many :objetos

  #Validar se existem os atributos
  validates_preence_of :tipoType, :value, :descriptionObjeto

  def initialize(type,value,descriptionObjeto)
    super
    @tipoType = type
    @TipoValues = value
    @descriptionObjetos = descriptionObjeto
    self.save!
  end

  def addObjeto(objeto)
    @objetos << objeto
    self.save!
  end
   
  def has_Objeto?(objeto)
    @objeto.include?(objeto)
  end


end
