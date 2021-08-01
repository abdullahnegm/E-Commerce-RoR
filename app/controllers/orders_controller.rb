class OrdersController < ApplicationController
    before_action :get_order, only: [:show]
    before_action :is_owner, only: [:show]

    def index
        orders = Order.all
        render json: { orders: orders.order_proj}
    end

    def show
        render json: { order: @order, items: @order.order_items, total_price: @order.get_total_price.to_i }
    end 

    private 
    def get_order
        @order = Order.find( params[:id] )
        # @order = Order.current_order current_user
    rescue
        render json: { message: 'Order Doesn\'t Exist' }, status: :bad_request 
    end

    def is_owner
        if current_user != @order.user
            render json: { message: 'You are not Authorized' }, status: :unauthorized 
        end
    end
end