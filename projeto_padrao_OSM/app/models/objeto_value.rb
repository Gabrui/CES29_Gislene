class ObjetoValue < ApplicationRecord :: Model
	#Representa as caracteristicas do Objeto
  #Colecao de Property
	has_many :propertys

  #metodo para adicionar property em propertys
	def << (property)
	   @propertys << property
	end
end
