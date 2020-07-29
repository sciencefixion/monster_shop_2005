class Merchant::DashboardController < Merchant::BaseMerchantController
  def show
    @user = current_user
  end

  def index

  end
end
