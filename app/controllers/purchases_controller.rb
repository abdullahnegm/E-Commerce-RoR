class PurchasesController < ApplicationController
    before_action :get_order
    before_action :is_owner

    def create
        Stripe::Checkout::Session.create({
        success_url: root_url,
        cancel_url: root_url,
        payment_method_types: ['card'],
        line_items: [{
            name:     @order.id,
            amount:   @order.get_total_price.to_i,
            currency: 'usd',
            quantity: 1
        }],
        mode: 'payment',
        })

        @order.ordered_boolean = true
        @order.save()
    end


    private 

    def get_order
        @order = Order.current_order current_user
        render json: { message: 'Your Cart is Empty Poor man' } if @order.order_items.empty?
    end

    def is_owner
        if current_user != @order.user
            render json: { message: 'You are not Authorized' }, status: :unauthorized 
        end
    end

end