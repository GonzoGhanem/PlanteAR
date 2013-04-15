class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :purchase_id
      t.integer :product_id
      t.integer :amount
      t.decimal :unit_price
      t.decimal :discount

      t.timestamps
    end
  end
end
