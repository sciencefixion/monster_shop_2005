class Merchant::DashboardController < Merchant::BaseMerchantController
  def index
    @user = User.find(session[:user_id])
  end
end
