class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders

  enum status: [:pending, :packaged, :shipped, :cancelled]

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def date_created
    created_at.strftime("%d %B %Y")
  end

  def date_last_updated
    updated_at.strftime("%d %B %Y")
  end

  def total_quantity_of_items
    items.count
  end
end
