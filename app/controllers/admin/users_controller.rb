class Admin::UsersController < ApplicationController
    before_action :require_admin
    def index
        
    end

    def show
        
    end

    private
    def require_admin
        render file: "/public/403" unless current_admin?
    end
    
end