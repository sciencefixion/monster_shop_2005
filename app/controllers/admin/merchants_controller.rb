class Admin::MerchantsController < Admin::BaseAdminController
    def index
        @merchants = Merchant.all
    end
    
end