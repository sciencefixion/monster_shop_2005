class Merchant::ItemsController < Merchant::BaseMerchantController
    def index
        @items = current_user.merchant.items 
    end

    def update
        item = Item.find(params[:item_id])
        if item.active?
            item.update(active?: false)
            flash[:success] = "#{item.name} is no longer for sale"
        else
            item.update(active?: true)
            flash[:success] = "#{item.name} is for sale"

        end

        redirect_to "/merchant/items"
    end
    
end