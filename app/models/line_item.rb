class LineItem < ActiveRecord::Base
  attr_accessible :amount, :discount, :product_id, :unit_price, :subtotal
  attr_accessible :products_attributes
  # attr_accessible :_destroy
  # attr_accessor :_destroy
  belongs_to :purchase
  has_one :product

  accepts_nested_attributes_for :product

  validates_presence_of :amount

end
