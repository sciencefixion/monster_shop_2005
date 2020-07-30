class Merchant::OrdersController < Merchant::BaseMerchantController
  def show
    @order = Order.find(params[:order_id])
    # require "pry"; binding.pry
    # ItemOrder.joins(:item).select("item.name", "item.price", "item.inventroy", "item_order.fulfilled").where('item.merchant_id = ?', current_user.merchant_id)
    # @items = @order.item_orders.find_all do |io|
    #   current_user.merchant_id == Item.find(io.item_id).merchant_id
    end

    def update
      order = Order.find(params[:order_id])
      require "pry"; binding.pry
    end
end
