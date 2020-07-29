class Merchant::DashboardController < Merchant::BaseMerchantController
  def show
    @user = User.find(session[:user_id])
  end
end
