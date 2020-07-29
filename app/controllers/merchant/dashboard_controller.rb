class Merchant::DashboardController < Merchant::BaseMerchantController
  def show
    @user = current_user
  end

  def item_index
  end
end
