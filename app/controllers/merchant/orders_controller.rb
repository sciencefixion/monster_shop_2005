class Merchant::OrdersController < Merchant::BaseMerchantController
  def show
    @order = Order.find(params[:order_id])
  end
end
