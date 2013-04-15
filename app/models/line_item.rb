class LineItem < ActiveRecord::Base
  attr_accessible :amount, :discount, :product_id, :unit_price, :subtotal
  attr_accessible :products_attributes
  attr_accessible :_destroy
  attr_accessor :_destroy
  belongs_to :purchase
  has_one :product

  accepts_nested_attributes_for :product

  #before_create :search_product

  def search_product
  	Product.find(product_id)
  rescue ActiveRecord::RecordNotFound
  	product = Product.new(:list_price=>unit_price, :stock=>amount)
  	product.save
  end
end
