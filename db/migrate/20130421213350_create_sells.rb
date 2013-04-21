class CreateSells < ActiveRecord::Migration
  def change
    create_table :sells do |t|
      t.decimal :amount
      t.date :date
      t.string :payment_type

      t.timestamps
    end
  end
end
