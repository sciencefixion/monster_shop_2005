class Admin::MerchantsController < Admin::BaseAdminController
    def index
        @merchants = Merchant.all
    end

    def update
        merchant = Merchant.find(params[:merchant_id])
        merchant.items.each do |item|
            item.update(enabled?: false)
        end
        merchant.update(enabled: false)
        
        flash[:success] = "#{merchant.name} has been disabled"
        redirect_to admin_merchants_path
    end
    
    
end