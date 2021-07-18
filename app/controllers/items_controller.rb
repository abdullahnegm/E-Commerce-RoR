class ItemsController < ApplicationController
    before_action :item_params, only: [:create, :update]
    before_action :get_item, only: [:destroy, :update, :show]

    def index
        @items = Item.all
        render json: @items
    end

    def show
        render json: @item
    end

    def create
        @item = Item.new(item_params)
        @item.save ? 
            (render json: @item, response: "Item Created Successfully", status: :created) : 
            (render json: { errors: @item.errors }, status: :bad_request)
    end

    def update
        @item.update(item_params) ? 
            (render json: @item, response: "Item Updated Successfully", status: :created) : 
            (render json: { errors: @item.errors }, status: :bad_request)
    end

    def destroy
        @item.destroy
        render json: {response: "Item deleted successfully", user: @user}
    end

    private
    def item_params
        params.permit(:title, :price, :dis_price, :description, :picture)
    end

    def get_item
        @item = Item.find( params[:id].to_i )
    rescue
        render json: {error: "Item not found"}, status: :not_found
    end

end