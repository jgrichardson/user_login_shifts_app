class Api::V1::ShiftsController < ApplicationController
    
    def index
        @shifts = Shift.where(user_id: params[:user_id])
        render json: @shifts, status: :ok
    end

end