class Objeto <  ApplicationRecord :: Model
  
  #Classe que representa a abstração Objeto
  
  #Todo Objeto tem value que é uma coleção de Property
  has_one :objetoValues
  
  #Todo Objeto tem um ObjetoType
  has_one :objetoType , dependent: :destroy
  
  #Todo Objeto pertence a um Tipo
  belong_to :tipo 

  #Validar existência dos atributos
  validates_presence_of :objetoType , :value

  def initialize(type,value,tipo)
    super
    @objetoValues = value
    @objetoType = type
    @tipo = tipo
    self.save!
  end

  def name
      @objetoType.name
  end
end
