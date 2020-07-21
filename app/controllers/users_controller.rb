class UsersController < ApplicationController
    def new
        
    end

    def create
        
        user = User.new(user_params)

        if user.save
            redirect_to "/profile"

            flash[:success] = "#{user.name} has been registered and logged in"
        else
            flash[:error] = "User could not be created: #{user.errors.full_messages.each {|msg| msg}}" 
            redirect_to "/register"
        end
        
    end

    private

    def user_params
        params.permit(:name, :address, :city, :state, :zip, :email, :password)
    end
    
    
end