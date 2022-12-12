class Api::V1::SessionsController < ActionController::Base
    skip_before_action :verify_authenticity_token

    # Login by creating a session.
    def create
        # Find the current user by their user_name
        if user = User.find_by(user_name: params[:user_name], password: params[:password])
            session[:session_id] = SecureRandom.uuid
            response.set_cookie :session_id, session[:session_id]
            user.update!(session_id: session[:session_id])
            render json: @user, status: :ok
        else
            render json: { error: 'Access denied: 401' }, status: :unauthorized
        end
    end

    # Action to logout by destroying the session.
    def destroy 
        puts "COOKIE"
        puts cookies[:session_id]
        if user = User.find_by(session_id: cookies[:session_id])
            puts "User logged out"
            session.delete(:session_id)
            user.update!(session_id: nil)
        else
            render json: { error: 'Access denied: 401' }, status: :unauthorized
        end
    end

end