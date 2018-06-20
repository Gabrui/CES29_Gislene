# == Schema Information
#
# Table name: description_objetos
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DescriptionObjeto < ApplicationRecord
	#Representa a descricao do Objeto
  #Colecao de Property
	has_many :propertys	
  
  #Metodo para adicionar property em propertys
	#def << (property)
	#   @propertys << property
  #      end
end
