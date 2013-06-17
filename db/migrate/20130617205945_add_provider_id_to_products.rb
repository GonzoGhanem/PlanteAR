class AddProviderIdToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :provider_id, :string
  end
end
