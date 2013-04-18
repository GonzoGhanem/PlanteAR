class LineItem < ActiveRecord::Base

  include ActiveModel::Dirty

  attr_accessible :amount, :discount, :product_id, :unit_price, :subtotal
  attr_accessible :products_attributes
  # attr_accessible :_destroy
  # attr_accessor :_destroy
  belongs_to :purchase
  has_one :product

  accepts_nested_attributes_for :product

  validates_presence_of :amount, :message => "La cantidad no puede estar en blanco"
  validates_numericality_of :amount, :greater_than => 0, :unless => lambda { self.amount.blank? },:message => "La cantidad no puede ser Negativa"

  validates_presence_of :unit_price, :message => "El precio unitario no puede estar en blanco"
  validates_numericality_of :unit_price, :greater_than => 0, :unless => lambda { self.unit_price.blank? }, :message => "El precio unitario no puede ser Negativo"
  
  validates_presence_of :subtotal, :message => "El subtotal no puede estar en blanco"
  validates_numericality_of :subtotal, :greater_than => 0,:unless => lambda { self.subtotal.blank? }, :message => "El subtotal no puede ser negativo"

end
