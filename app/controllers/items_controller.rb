class ItemsController < ApplicationController
    before_action :item_params, only: [:create, :update]

    def index
        @items = Item.all
        render json: @items
    end

    def show
        @item = Item.find( params[:id].to_i )
        render json: @item
    rescue
        render json: {error: "Item not found"}, status: 404
    end

    def create
        @item = Item.new(item_params)
        @item.save ? 
            (render json: @item, response: "Item Created Successfully") : 
            (render json: { errors: @item.errors })
    end

    def update
        @item = Item.find( params[:id].to_i )
        @item.update(item_params) ? 
            (render json: @item, response: "Item Updated Successfully") : 
            (render json: { errors: @item.errors })
    end

    def destroy
        @item = Item.find( params[:id].to_i )
        @item.destroy
        render json: {response: "Item deleted successfully"}
    rescue
        render json: {error: "Item not found"}, status: 404
    end

    private
    def item_params
        params.permit(:title, :price, :dis_price, :description, :picture)
    end

end