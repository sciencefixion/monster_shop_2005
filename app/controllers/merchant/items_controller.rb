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

    def delete
        item = Item.find(params[:item_id])
        item.destroy  if item.orders.empty?
       
        flash[:success] = "Item has been deleted."
        redirect_to merchant_items_path
    end

    def new
        
    end

    def create
        item = current_user.merchant.items.new(item_params)
        if item.save
            flash[:success] = 'The Item has been created successfully.'
            redirect_to merchant_items_path
        else
            p "x"
        end
        
    end
    
    private
    def item_params
        params.permit(:name, :description, :image, :price, :inventory)
    end
    
    
    
    
end