class ChangeColumnToSells < ActiveRecord::Migration
  def up
  	rename_column :sells, :payment_type, :payment_type_id
  end

  def down
  end
end
