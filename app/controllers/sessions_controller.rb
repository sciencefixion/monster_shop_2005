class SessionsController < ApplicationController
  def show
    
  end

  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/profile"
      flash[:notice] = "You are now logged in."
    else
      flash[:error] = "You are not logged in."
      redirect_to "/login"
    end

  end
end
