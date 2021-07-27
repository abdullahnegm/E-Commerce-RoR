class AuthenticationController < ApplicationController
    skip_before_action :authorized

    def login 
        user = User.find_by( username: params[:username] )
        user.authenticate(params[:password]) 
        token = AuthenticationTokenService.encode_token({ user_id: user.id })
        render json: { user_id: user.id, token: token }
    rescue
        render json: { message: "User name or password is incorrect!" }
    end

end