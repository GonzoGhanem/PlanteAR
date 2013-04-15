class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.decimal :list_price
      t.decimal :sell_price
      t.integer :stock

      t.timestamps
    end
  end
end
