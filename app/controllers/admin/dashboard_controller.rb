class Admin::DashboardController < Admin::BaseAdminController
  def index
    @user = User.find(session[:user_id])
  end
end
