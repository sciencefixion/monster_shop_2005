class AddDefaultToImageInItem < ActiveRecord::Migration[5.1]
  def change
    change_column_default :items, :image, from: nil , to: "https://tazacommune.com/wp-content/plugins/wp-appkit/default-themes/q-ios/img/img-icon.svg", null: false
  end
end
