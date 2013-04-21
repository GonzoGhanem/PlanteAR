class AddColumnToLineItems < ActiveRecord::Migration
  def change
      add_column :line_items, :line_itemable_type, :string
      rename_column :line_items, :purchase_id, :line_itemable_id
  end
end
