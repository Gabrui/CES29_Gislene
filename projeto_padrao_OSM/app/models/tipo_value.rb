class TipoValue < ApplicationRecord :: Model
	#Representa as caracteristicas do Tipo
  #Colecao de Property
	has_many :propertys	

  #metodo para adicionar Property em propertys
	def << (property)
	   @propertys << property
        end
end
