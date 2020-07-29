class AddFulfillToItemOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :item_orders, :fulfulled, :boolean, default: false
  end
end
