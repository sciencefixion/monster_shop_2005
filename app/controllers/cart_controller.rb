class CartController < ApplicationController
  before_action :cart_authorization
  def add_item
    item = Item.find(params[:item_id])
    cart.add_item(item.id.to_s)
    flash[:success] = "#{item.name} was successfully added to your cart"
    redirect_to "/items"
  end

  def show
    @items = cart.items
  end

  def empty
    session.delete(:cart)
    redirect_to '/cart'
  end

  def remove_item
    session[:cart].delete(params[:item_id])
    redirect_to '/cart'
  end

  def update
    if params[:type].eql?('add')
      cart.add_item(params[:item_id])
      return redirect_to cart_path
    end
  end
  

  private
  def cart_authorization
    render file: "/public/403" if current_admin?
  end
end
