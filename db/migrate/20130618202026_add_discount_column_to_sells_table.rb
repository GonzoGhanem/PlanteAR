class AddDiscountColumnToSellsTable < ActiveRecord::Migration
  def change
  	add_column :sells, :discount, :decimal
  end
end
