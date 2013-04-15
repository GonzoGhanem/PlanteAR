class AddSubtotalToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :subtotal, :decimal
  end
end
