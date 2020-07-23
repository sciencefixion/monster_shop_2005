class UsersController < ApplicationController
    def new

    end

    def create
      user = User.new(user_params)
      if user.save
        session[:user_id] = user.id
        redirect_to "/profile"
        flash[:success] = "#{user.name} has been registered and logged in"
      else
        flash[:error] = "User could not be created: #{user.errors.full_messages.each {|msg| msg}}"
        redirect_to "/register"
      end
    end

    def edit
      @user = current_user
    end

    def update
      user = current_user
      if user.update_attributes(user_params_update)
        flash[:success] = "Your profile has been updated"
        redirect_to "/profile"
      else user.errors.any?
        flash[:error] = "User could not be updated: #{user.errors.full_messages.each {|msg| msg}}"
        redirect_to "/profile/edit"
      end
    end

    private
    def user_params
      params.permit(:name, :address, :city, :state, :zip, :email, :password)
    end

    def user_params_update
      params.permit(:name, :address, :city, :state, :zip, :email)
    end
end
