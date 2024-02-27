class StatusesController < ApplicationController
  before_action :set_status, only: [:show, :edit, :update, :destroy]
  def index
    @user = current_user
    if current_user.admin?
      @statuses = Status.all
    else
      @statuses = current_user.statuses
    end
  end

  def show
  end

  def new
    @status = Status.new
  end

  def create
    @status = Status.new(status_params)
    @status.user = current_user
    if @status.save
      flash[:notice] = "Status created successfully"
      redirect_to status_path(@status)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @status.update(status_params)
      flash[:notice] = "Status updated successfully"
      redirect_to @status
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @status.destroy
    flash[:notice] = "Status deleted successfully"
    redirect_to statuses_path
  end

  private

  def set_status
    @status = Status.find(params[:id])
  end

  def status_params
    params.require(:status).permit(:github_pr_link, :date, :user_id, :remarks, tasks_attributes: [:id, :start_time, :end_time, :title, :description, :output_screenshot])
  end

end
