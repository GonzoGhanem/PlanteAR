class Purchase < ActiveRecord::Base
  attr_accessible :amount, :date, :provider_id
  attr_accessible :line_items_attributes
  belongs_to :provider
  has_many :line_items, dependent: :destroy 
  accepts_nested_attributes_for :line_items, :reject_if => lambda { |a| a[:product_id].blank? }, :allow_destroy => true

  validates_presence_of :date, :message=>"La fecha no puede estar en blanco"
  validates_presence_of :provider_id, :message=>"Debe seleccionar un Proveedor para registrar la compra"
  validates_presence_of :line_items, :message=>"Al menos debe completar una linea de compra"
end