class ShiftsController < ApplicationController

  def index
    if params[:user_id]
      @shifts = Shift.where(user_id: params[:user_id])
    else
      @shifts = Shift.all
    end
   
    render do |format|
      format.html
      format.json { render json: @shifts, status: :ok }
    end
  end

  def new
    @shift = Shift.new
    render :new
  end

  def create
    @shift = Shift.new(shift_params)
    if @shift.save
      redirect_to shifts_path
    else
      render :new
    end
  end

  def update
    load_shift
    if @shift.update(shift_params)
      redirect_to shifts_path
    else
      render :edit
    end
  end

  def edit
    load_shift
    render :edit
  end

  def destroy
    load_shift
    if @shift.destroy
      redirect_to shifts_path
    else
      redirect_to @shift
    end
  end

  def show
    load_shift
    render do |format|
      format.html
      format.json { render json: @shift }
    end
  end

  private

  def load_shift
    @shift ||= Shift.find(params[:id])
  end

  def shift_params
    params.require(:shift).permit(:start_at, :end_at, :role, :user_id)
  end
end
