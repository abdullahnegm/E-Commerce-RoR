class AuthenticationTokenService

    def self.encode_token payload
        JWT.encode payload, 'this is a secret don\'t tell anyone', 'HS256'
    end

    def self.decoded_token auth_header
        token = auth_header.split(' ')[1]
        begin
            JWT.decode(token, 'this is a secret don\'t tell anyone', true, algorithm: 'HS256')
        rescue JWT::DecodeError
            nil
        end
    end

end