class OrdersController <ApplicationController

  def index
    @orders = current_user.orders
  end

  def new

  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    order = current_user.orders.create(order_params)

    if order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
      end
      session.delete(:cart)
      redirect_to "/profile/orders"
      flash[:notice] = "You order has been created"
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end

  def update
    order = Order.find(params[:id])
    order.update(status: 2) if order.status == 'packaged'

    redirect_to admin_dashboard_path
  end
  
  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
