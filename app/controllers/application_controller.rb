class ApplicationController < ActionController::API
    def authenticate_admin!
        token = request.headers['Authorization']&.split(' ')&.last
        decoded_token = JWT.decode(token, 'your-secret-key', true, algorithm: 'HS256')
    
        admin_id = decoded_token.first['admin_id']
        @current_admin = Admin.find(admin_id)
      rescue JWT::DecodeError
        render json: { error: 'Unauthorized' }, status: :unauthorized
    end
end
