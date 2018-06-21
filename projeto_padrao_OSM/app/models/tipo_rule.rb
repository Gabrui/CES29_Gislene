# == Schema Information
#
# Table name: tipo_rules
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TipoRule < ApplicationRecord

  #Regra de criação de Tipo

  def create (type,values,valueNames,descriptionObj,descriptionObjNames)
     
      #criar a coleção de propriedade de Tipo
      properties = TipoValue.new()
      values.zip(valueNames).each do |value, name|
            properties.propertys << PropertyType.new(name, value).property
      end
      properties.save
      #criar a coleção de propriedade da descrição dos Objeto de Tipo
      description = DescriptionObjeto.new()
      descriptionObj.zip(descriptionObjNames).each do |desc,name|
            description.propertys << PropertyType.new(name, desc).property
      end
      description.save
      #criar Tipo e retorná-lo
      Tipo.new(type,properties,description)

  end
end
