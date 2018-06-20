# == Schema Information
#
# Table name: property_rules
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PropertyRule < ApplicationRecord

  #Regra de criação da Property
  def create (value)
    #criar Property
    p = Property.new
    p.value =value
    return p
  end
end
