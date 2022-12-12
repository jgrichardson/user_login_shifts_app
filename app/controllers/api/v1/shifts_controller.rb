class Api::V1::ShiftsController < ActionController::Base
    skip_before_action :verify_authenticity_token

    def index
        if user = User.find_by(session_id: cookies[:session_id])
            @shifts = Shift.where(user_id: params[:user_id])
            render json: @shifts, status: :ok
        else
            render json: { error: 'Access denied: 401' }, status: :unauthorized
        end
    end
end
