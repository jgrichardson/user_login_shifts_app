class Api::V1::SessionsController < ApplicationController

    # Login by creating a session.
    def create
        # Find the current user by their user_name
        @user = User.find_by(user_name: params[:user_name])

        if @user.present? && @user.authenticate(params[:password])
            session[:user_name] = @user.user_name
            session[:session_id] = SecureRandom.hex(16)
            response.set_header('Set-Cookie', session[:session_id])
            render json: @user, status: :ok
        else
            render json: { error: 'Access denied: 401' }, status: :unauthorized
        end
    end

    # Action to logout by destroying the session.
    def destroy
        session.delete(:user_name)
    end

end