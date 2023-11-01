require 'jwt'
class AdminController < ApplicationController
    def login
        admin = Admin.find_by(username: params[:username])
        if admin&.authenticate(params[:password])
          access_token = generate_access_token(admin)
          render json: { access_token: access_token }
        else
          render json: { error: 'Invalid username or password' }, status: :unauthorized
        end
    end

    private
    def generate_access_token(admin)
        payload = { admin_id: admin.id, exp: 1.hour.from_now.to_i }
        JWT.encode(payload, 'your-secret-key', 'HS256')
    end
end
