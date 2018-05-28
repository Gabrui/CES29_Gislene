class ObjetoRule < ApplicationRecord :: Model

  #Regra de crição  de Objeto
  def create (type,valueNames, values, tipo)
    
    #Criar coleção de Property de Objeto
    properties = ObjetoValue.new()
    values.zip(valueNames).each do |value, name|
        properties << PropertyType.new(name,value).property
    end
    properties.save

    #Criar Objeto
    obj = Objeto.new(type,properties,tipo)
    
    #adicionar Objeto ao Tipo
    tipo.addObjeto(obj)
    
    #retornar Objeto criado
    obj

  end
end
