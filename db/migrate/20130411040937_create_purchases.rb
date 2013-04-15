class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :provider_id
      t.date :date
      t.decimal :amount

      t.timestamps
    end
  end
end
