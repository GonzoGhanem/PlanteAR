class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :city
      t.string :state
      t.text :comments

      t.timestamps
    end
  end
end
