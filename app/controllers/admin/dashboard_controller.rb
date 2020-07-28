class Admin::DashboardController < Admin::BaseAdminController
  def index
    if params[:status] && !params[:status].empty?
      return @orders = Order.where(status: params[:status]) 
    end 
    @orders = Order.all
  end
end
