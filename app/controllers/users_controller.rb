class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def dashboard
    @user = current_user
  end

  private
  def user_params
    params.require(:user).permit(:name, :role)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
