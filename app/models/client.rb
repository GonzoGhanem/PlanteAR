class Client < ActiveRecord::Base
  attr_accessible :address, :city, :comment, :email, :name, :phone, :state, :zip_code

  has_many :sells, :through => :line_items, :source => :line_itemable, :source_type => "Sell"
  
  validates_presence_of :name, :message => "El Nombre no puede estar en blanco"
  validates_uniqueness_of :name, :message => "El Cliente ya existe"

end
