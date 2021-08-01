class CheckOutsController < ApplicationController
    before_action :get_order
    before_action :check_billing_address

    def create
        billing_address = BillingAddress.create(checkout_params)
        current_user.billing_addresses << billing_address
        @order.billing_address_id = billing_address.id
        if @order.save
            render json: { order: @order }, status: :created 
        else
            render json: { errors: @order.errors }, status: :bad_request
        end
    end

    def update
        if @order.billing_address.update(checkout_params)
            render json: { order: @order }, status: 200 
        else
            render json: { errors: @order.errors }, status: :bad_request
        end
    end

    private
    def get_order
        @order = Order.current_order current_user
    end

    def check_billing_address
        if @order.billing_address && params[:action] == "create"
            render json: { errors: "Billing address already exists" }, status: :bad_request
        elsif @order.billing_address.nil? && params[:action] == "update"
            render json: { errors: "Billing address doesn\'t exists" }, status: :bad_request
        end
    end

    def checkout_params
        params.permit(:shipping_address)
    end

end