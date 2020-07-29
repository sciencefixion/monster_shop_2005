class Merchant <ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :item_orders, through: :items
  has_many :users

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip


  def no_orders?
    item_orders.empty?
  end

  def item_count
    items.count
  end

  def average_item_price
    items.average(:price)
  end

  def distinct_cities
    item_orders.distinct.joins(:order).pluck(:city)
  end

  def pending_orders
    Order.joins(:item_orders).group(:id).where('orders.status = 0')
  end

  # def pending_orders
  #   order = []
  #   item_orders.each do |item_order|
  #     order << Order.find(item_order.order_id) if Order.find(item_order.order_id).status == "pending"
  #   end
  #   order.uniq
  # end
end
