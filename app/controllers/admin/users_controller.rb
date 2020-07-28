class Admin::UsersController < Admin::BaseAdminController
    def show
     @user = User.find(params[:user_id])  
    end
end