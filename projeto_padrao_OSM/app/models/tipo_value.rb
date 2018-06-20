# == Schema Information
#
# Table name: tipo_values
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TipoValue < ApplicationRecord
  #Representa as caracteristicas do Tipo
  #Colecao de Property
	has_many :properties
	belongs_to :tipo
	
	#def initialize
	#	@propertys = self.propertys.build
	#end

  #metodo para adicionar Property em propertys
	#def << (property)
	#	 puts @propertys
  #   @propertys << property
  #end
end
