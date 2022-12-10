class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    helper_method :current_user
    helper_method :logged_in?

    def current_user
      # finds user by their session data and stores it
      User.find_by(user_name: session[:user_name])
    end

    def logged_in?
        # Returns true if there is a current user, false otherwise
        !current_user.nil?
    end

end
