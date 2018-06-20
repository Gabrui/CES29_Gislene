# == Schema Information
#
# Table name: objeto_values
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ObjetoValue < ApplicationRecord
	#Representa as caracteristicas do Objeto
  #Colecao de Property
	has_many :propertys

  #metodo para adicionar property em propertys
	def << (property)
	   @propertys << property
	end
end
