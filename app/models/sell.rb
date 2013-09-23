class Sell < ActiveRecord::Base
  attr_accessible :amount, :date, :payment_type_id, :discount
  attr_accessible :line_items_attributes
  attr_accessible :payment_type_attributes
  attr_accessible :products_attributes
  
  
  has_many :line_items, :as => :line_itemable
  has_many :products, :through => :line_items
  
  has_one :payment_type

  accepts_nested_attributes_for :line_items, :reject_if => lambda { |a| a[:product_id].blank? && a[:line_item_product_name].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :payment_type

  validates_presence_of :date, :message=>"La fecha no puede estar en blanco"
  validates_presence_of :line_items, :message=>"Al menos debe completar una linea de venta"
  validates_presence_of :payment_type_id, :message=>"Debe seleccion un metodo de pago"


  def update_products(action)
    if(action == "Insert")
        line_items.each do |line| 
          if (Product.exists?(line.product_id) )
            @product = Product.find(line.product_id)
            @product.list_price = line.unit_price
            @product.sell_price = line.line_item_product_sell_price
            @product.stock = @product.stock.to_i - line.amount unless @product.stock.to_i == 0
            @product.save
          else
            @product = Product.find_by_name(line.line_item_product_name)
            @product.name = line.line_item_product_name
            @product.list_price = line.unit_price
            @product.sell_price = line.line_item_product_sell_price
            @product.stock = 0
            @product.save
          end
        end
    elsif (action == "Update")
        line_items.each do |line|
          if (line.previous_changes[:product_id].nil?)
              @product = Product.find(line.product_id)
              @product.sell_price = line.previous_changes[:unit_price][1] unless line.previous_changes[:unit_price].nil?
              @product.stock = @product.stock.to_i + line.previous_changes[:amount][0] - line.previous_changes[:amount][1] unless (line.previous_changes[:amount].nil?) 
              @product.save
            elsif (line.previous_changes[:product_id][0] == nil)
              @product = Product.find(line.product_id)
              @product.sell_price = line.unit_price
              @product.stock = @product.stock.to_i - line.amount
              @product.save
          end
        end
    end
end
end
