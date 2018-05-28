class DescriptionObjeto < ApplicationRecord :: Model
	#Representa a descricao do Objeto
  #Colecao de Property
	has_many :propertys	
  
  #Metodo para adicionar property em propertys
	def << (property)
	   @propertys << property
        end
end
