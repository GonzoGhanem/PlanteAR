class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :zip_code
      t.string :city
      t.string :state
      t.string :comment
      t.string :email

      t.timestamps
    end
  end
end
