class SessionsController < ApplicationController

    # Login by creating a session.
    def create
        # Find the current user by their user_name
        @user = User.find_by(user_name: params[:user_name])

        # Check if user exists and if the password is correct
        if @user.present? && @user.authenticate(params[:password])
            session[:user_name] = @user.user_name
            redirect_to(root_path, notice: "You are now logged in.") 
        else
            flash.now[:alert] = "You entered an incorrect user name or password."
            render :new, status: :unprocessable_entity
        end
    end

    # Action to logout by destroying the session.
    def destroy
        session.delete(:user_name)
        @current_user = nil
        redirect_to root_path, notice: 'You have been logged out.'
    end

    # Renders the login form.
    def new; end

end