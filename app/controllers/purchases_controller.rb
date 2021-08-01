class PurchasesController < ApplicationController
    before_action :get_order
    before_action :is_owner

    def create
        p "Worked 1"
        p "Worked 1"
        p "Worked 1"
        p "Worked 1"
        p "Worked 1"
        p "Worked 1"
        Stripe::Checkout::Session.create({
        success_url: root_url,
        cancel_url: root_url,
        payment_method_types: ['card'],
        line_items: [{
            name:     @order.id,
            amount:   @order.get_total_price.to_i * 100,
            currency: 'usd',
            quantity: 1
        }],
        mode: 'payment',
        })

        @order.ordered_boolean = true
        @order.save()
        p "Worked 2"
        render json: {message: "Worked"}
    end


    private 

    def get_order
        @order = Order.current_order current_user
        render json: { message: 'Your Cart is Empty Poor man' } if @order.order_items.empty?
    end

    def is_owner
        if current_user != @order.user
            render json: { message: 'You are not Authorized' }, status: :unauthorized 
        elsif @order.billing_address.nil? 
            render json: { message: 'Wrong Data' }, status: :bad_request
        end
    end

end