class SessionsController < ApplicationController
  def show
    render file: "public/404.html" if !current_user
  end

  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if current_merchant?
        redirect_to "/merchant/dashboard"
        flash[:notice] = "You are now logged in."
      elsif current_admin?
        redirect_to "/admin/dashboard"
        flash[:notice] = "You are now logged in."
      else
        redirect_to "/profile"
        flash[:notice] = "You are now logged in."
      end
    else
      flash[:error] = "You are not logged in. Username and/or password are incorrect"
      redirect_to "/login"
    end
  end
end
