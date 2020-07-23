class PasswordsController < ApplicationController
    def edit
        
    end

    def update
        if params[:new_password].eql?(params[:confirm_password])
            current_user.update(password: params[:new_password])
            flash[:success] = "Password updated"
            return redirect_to "/merchant/dashboard" if current_user.merchant?
            return redirect_to "/admin/dashboard" if current_user.admin?
            return redirect_to "/profile" if current_user.default?
        end
        flash[:error] = "Password did not match"
        redirect_to "/users/password/edit"
    end
end