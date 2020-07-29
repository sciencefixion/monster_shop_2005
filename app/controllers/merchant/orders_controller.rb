class Merchant::OrdersController < Merchant::BaseMerchantController
  def show
    @order = Order.find(params[:order_id])
    # @items = ItemOrder.joins(:order).joins(:item).where('item.merch')
    # require "pry"; binding.pry
  end
end
