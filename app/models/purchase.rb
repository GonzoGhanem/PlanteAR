class Purchase < ActiveRecord::Base
  attr_accessible :amount, :date, :provider_id
  attr_accessible :line_items_attributes
  belongs_to :provider
  has_many :line_items, :as => :line_itemable
  has_many :products, :through => :line_items
  
   # has_many :line_items, dependent: :destroy 
  accepts_nested_attributes_for :line_items, :reject_if => lambda { |a| a[:product_id].blank? && a[:line_item_product_name].blank? }, :allow_destroy => true

  validates_presence_of :date, :message=>"La fecha no puede estar en blanco"
  validates_presence_of :provider_id, :message=>"Debe seleccionar un Proveedor para registrar la compra"
  validates_presence_of :line_items, :message=>"Al menos debe completar una linea de compra"

  def update_products(action)
    if(action == "Insert")
        line_items.each do |line| 
          if (Product.exists?(line.product_id) )
            @product = Product.find(line.product_id)
            @product.list_price = line.unit_price
            @product.provider_id = self.provider_id
            @product.sell_price = line.line_item_product_sell_price
            @product.stock = @product.stock.to_i + line.amount
            @product.save
          else
            @product = Product.find_by_name(line.line_item_product_name)
            @product.name = line.line_item_product_name
            @product.list_price = line.unit_price
            @product.provider_id = self.provider_id
            @product.sell_price = line.line_item_product_sell_price
            @product.stock = line.amount
            @product.save
          end
        end
    elsif (action == "Update")
        line_items.each do |line|
          line_changes = line.previous_changes
          if (line_changes[:product_id].nil?)
              @product = Product.find(line.product_id)
              @product.list_price = line_changes[:unit_price][1] unless line_changes[:unit_price].nil?
              @product.stock = @product.stock.to_i - line_changes[:amount][0].to_i + line_changes[:amount][1].to_i unless (line_changes[:amount].nil?) 
              @product.save
            elsif (line_changes[:product_id][0] == nil)
              @product = Product.find(line.product_id)
              @product.list_price = line.unit_price
              @product.stock = @product.stock.to_i + line.amount
              @product.save
          end
        end
    end
  end
end