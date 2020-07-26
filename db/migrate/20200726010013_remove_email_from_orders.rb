class RemoveEmailFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :email, :string
  end
end
