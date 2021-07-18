class ApplicationController < ActionController::API
    before_action :authorized

    def logged_in_user
        header = request.headers['Authorization']
        if header && AuthenticationTokenService::decoded_token( header )
            user_id = AuthenticationTokenService.decoded_token( header )[0]['user_id']
            @user = User.find_by(id: user_id)
        else
            render json: { message: "User is not authenticated" }
        end
    end
    
    def logged_in?
        !!logged_in_user
    end
    
    def authorized
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end


end
