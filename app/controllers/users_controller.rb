class UsersController < ApplicationController
    before_action :user_params, only: [:create, :update]
    before_action :get_user, only: [:destroy, :update, :show]
    skip_before_action :authorized, only: [:create]

    def index
        users = User.all
        render json: users
    end

    def show
        render json: @user
    end

    def create
        @user = User.new(user_params)
        @user.save ? 
            (render json: @user, response: "User Updated Successfully", status: :created) : 
            (render json: { errors: @user.errors }, status: :bad_request)
    end

    def update
        @user.update(user_params) ? 
            (render json: @user, response: "User Updated Successfully", status: :created) : 
            (render json: { errors: @user.errors }, status: :bad_request)
    end

    def destroy
        @user.destroy
        render json: {response: "User deleted successfully", user: @user}
    end


    private 
    def user_params 
        params.permit(:username, :password, :email)
    end

    def get_user
        @user = User.find( params[:id] )
    rescue
        render json: {error: "User not found"}, status: :not_found
    end

end