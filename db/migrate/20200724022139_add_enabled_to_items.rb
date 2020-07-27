class AddEnabledToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :enabled?, :boolean, default: true
  end
end
