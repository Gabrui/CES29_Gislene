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
  def create (type,value)
    #criar Property
    Property.new(type,value)
  end
end
