class ItemOrder <ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity

  belongs_to :item
  belongs_to :order

  def subtotal
    price * quantity
  end

  def self.five_most_popular
    ItemOrder.select("item_id, sum(quantity) AS total").group(:item_id).order("total DESC").limit(5).map {|item_order| item_order.item}
  end

  def self.five_least_popular
    ItemOrder.select("item_id, sum(quantity) AS total").group(:item_id).order("total").limit(5).map {|item_order| item_order.item}
  end

  def self.total_ordered(item)
    item.item_orders.sum(:quantity)
  end

  def orders

  end
end
