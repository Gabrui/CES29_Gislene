# == Schema Information
#
# Table name: aom_atributos
#
#  id          :bigint(8)        not null, primary key
#  nome        :text
#  descricao   :text
#  aom_tipo_id :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_aom_atributos_on_aom_tipo_id  (aom_tipo_id)
#
# Foreign Keys
#
#  fk_rails_...  (aom_tipo_id => aom_tipos.id)
#

class AomAtributo < ApplicationRecord
  belongs_to :aom_tipo
end
