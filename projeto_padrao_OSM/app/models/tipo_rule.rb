class TipoRule < ApplicationRecord :: Model

  #Regra de criação de Tipo

  def create (type,values,valueNames,descriptionObj,descriptionObjNames)
     
      #criar a coleção de propriedade de Tipo
      properties = TipoValue.new()
      values.zip(valueName).each do |value, name|
            properties << PropertyType.new(name, value).property
      end
      properties.save
      #criar a coleção de propriedade da descrição dos Objeto de Tipo
      description = DescriptionObjeto.new()
      descriptionObj.zip(descriptionObjNames).each do |description,name|
            description << PropertyType.new(name, description).property
      end
      description.save
      #criar Tipo e retorná-lo
      Tipo.new(type,properties,description)

  end
end
