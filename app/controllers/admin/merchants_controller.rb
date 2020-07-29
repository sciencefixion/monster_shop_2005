class Admin::MerchantsController < Admin::BaseAdminController
    def index
        @merchants = Merchant.all
    end

    def show

    end

    def update
        merchant = Merchant.find(params[:merchant_id])
        if merchant.enabled
            merchant.items.each do |item|
                item.update(enabled?: false)
            end
            merchant.update(enabled: false)
            flash[:success] = "#{merchant.name} has been disabled"
        else
            merchant.items.each do |item|
                item.update({enabled?: true, active?: true})
            end
            merchant.update(enabled: true)
            flash[:success] = "#{merchant.name} has been enabled"
        end

        redirect_to admin_merchants_path
    end


end
