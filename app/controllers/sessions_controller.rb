class SessionsController < ApplicationController
  def show

  end

  def new

  end

  def create

    redirect_to "/profile"
    flash[:notice] = "You are now logged in."
  end
end
