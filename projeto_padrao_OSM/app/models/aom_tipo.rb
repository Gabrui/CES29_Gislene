# == Schema Information
#
# Table name: aom_tipos
#
#  id         :bigint(8)        not null, primary key
#  nome_tipo  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  descricao  :text
#

class AomTipo < ApplicationRecord
    has_many :aom_atributos
end
