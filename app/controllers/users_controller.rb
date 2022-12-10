class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def update
    load_user
    if @user.update(user_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  def edit
    load_user
    render :edit
  end

  def destroy
    load_user
    if @user.destroy
      redirect_to users_path
    else
      redirect_to @user
    end
  end

  private

  def load_user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :user_name, :password)
  end

end
