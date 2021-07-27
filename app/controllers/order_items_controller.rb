class OrderItemsController < ApplicationController
    before_action :get_order_item, only: [:update, :delete]
    before_action :is_owner, except: [:create]


    def create 
        order = Order.current_order( current_user )
        order.order_items.create( order_item_create_params )
        render json: { order: order }    
    rescue
        render json: { message: "Something went wrong", status: :bad_request }
    end

    def update 
        @order_item.update(order_item_update_params)
        render json: { order_item: @order_item }    
    end

    def destroy
        @order_item.delete
        render json: {message: "Order item deleted Successfully", status: 200}
    end


    private 
    def order_item_create_params
        params.permit(:item_id, :quantity)
    end

    def order_item_update_params
        params.permit(:quantity)
    end

    private 
    def get_order_item
        @order_item = OrderItem.find( params[:id] )
    rescue
        render json: {Error: "Order item doesn't exist"}
    end

    def is_owner
        @order_item = OrderItem.find( params[:id] )
        if current_user != @order_item.order.user
            return render json: { message: 'You are not Authorized' }, status: :unauthorized 
        end
    end

end