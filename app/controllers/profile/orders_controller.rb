class Profile::OrdersController < Profile::BaseController
  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.status = "cancelled"
    order.save
    redirect_to "/profile"
    flash[:notice] = "Order number #{order.id} is now cancelled."
  end
end
