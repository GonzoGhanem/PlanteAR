class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :list_price, :name, :sell_price, :stock

  has_many :line_items

  validates_presence_of :name, :message => "El Nombre no puede estar en blanco"
  validates_presence_of :stock, :message => "El stock no puede estar vacio"
  validates_presence_of :list_price, :message => "El Precio de lista no puede estar vacio"

  validates_numericality_of :list_price, :greater_than => 0, :unless => lambda { self.list_price.blank? }, :message => "El precio de lista no puede ser Negativo" 
  validates_numericality_of :sell_price, :greater_than => 0, :unless => lambda { self.sell_price.blank? }, :message => "El precio de venta no puede ser Negativo" 
  validates_numericality_of :stock,:greater_than => -1, :unless => lambda { self.stock.blank? }, :message => "El stock no puede ser Negativo" 

  validates_numericality_of :stock, :only_integer => true, :unless => lambda { self.stock.blank? },  :message => "El Stock debe ser un numero entero"
  validates_numericality_of :list_price, :unless => lambda { self.list_price.blank? }, :message => "El Precio de list debe ser un numero"
  validates_numericality_of :sell_price, :unless => lambda { self.sell_price.blank? }, :message => "El Precio de venta debe ser un numero"
  
end
