class PropertyRule < ApplicationRecord :: Model

  #Regra de criação da Property
  def create (type,value)
    #criar Property
    Property.new(type,value)
  end
end
