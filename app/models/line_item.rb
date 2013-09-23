class LineItem < ActiveRecord::Base

  include ActiveModel::Dirty

  attr_accessible :amount, :discount, :product_id, :unit_price, :subtotal, :line_item_product_sell_price, :line_item_product_name
  attr_accessible :product_attributes
  # attr_accessible :_destroy
  # attr_accessor :_destroy
  belongs_to :line_itemable, :polymorphic => true

  # belongs_to :purchase
  belongs_to :product

  accepts_nested_attributes_for :product, :reject_if => lambda { |a| a[:product_id].blank? && a[:line_item_product_name].blank? }, :allow_destroy => true
  
  validates_presence_of :amount, :message => "La cantidad no puede estar en blanco"
  validates_numericality_of :amount, :greater_than => 0, :unless => lambda { self.amount.blank? },:message => "La cantidad no puede ser Negativa"

  validates_presence_of :unit_price, :message => "El precio unitario no puede estar en blanco"
  validates_numericality_of :unit_price, :greater_than => 0, :unless => lambda { self.unit_price.blank? }, :message => "El precio unitario no puede ser Negativo"
  
  validates_presence_of :subtotal, :message => "El subtotal no puede estar en blanco"
  validates_numericality_of :subtotal, :greater_than => 0,:unless => lambda { self.subtotal.blank? }, :message => "El subtotal no puede ser negativo"

  def line_item_product_sell_price
    product.sell_price if product.present?
  end

  def line_item_product_name
    product.name if product.present?
  end
  

  def line_item_product_sell_price= value
    if (Product.exists?(product_id))
      product = Product.find(product_id)
      product.sell_price = value
      product.save!
    end
  end

  def line_item_product_name= value
    if (Product.find_by_name(value) == nil && value != "")
      product = Product.new()
      product.name = value
      product.save!
      self.product_id = product.id
      self.save
    elsif (Product.find_by_name(value) != nil)
      product = Product.find_by_name(value)
      self.product_id = product.id
      self.save
    end
  end
end
