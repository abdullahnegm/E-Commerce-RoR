class OrderItemsController < ApplicationController
    before_action :get_order_item, only: [:update, :destroy]
    before_action :is_owner, except: [:create]
    before_action :get_order, only: [:create]


    def create 
        item  = Item.find( params[:item_id] )
        if @order.order_items.exists? item_id: item.id
            order_item = @order.order_items.where( item_id: item.id ).first
            order_item.quantity += params[:quantity]
            order_item.save
        else
            @order.order_items.create( item_id: params[:item_id], quantity: params[:quantity] )
        end
        render json: { order: @order.order_items.count }    
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
    def params_order_item
        params.permit(:quantity)
    end

    def get_order
        @order = Order.current_order( current_user )
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