class StatusesController < ApplicationController
  before_action :set_status, only: [:show, :edit, :update, :destroy, :resolve]
  def index
    @user = current_user
    if current_user.admin?
      @statuses = Status.all
    else
      @statuses = current_user.statuses
    end
    @remarks = Remark.includes(:status).where(status_id: @statuses.pluck(:id))
  end

  def show
    @user = current_user
  end

  def new
    @status = Status.new
  end

  def create
    @status = Status.new(status_params)
    @status.user = current_user
    if @status.save
      flash[:notice] = "Status created successfully"
      redirect_to statuses_path
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

  def resolve
    @remark = @status.remarks.where(params[:id, :status_id])
    @status.update(status: "Resolved")
    flash[:notice] = "Status resolved successfully"
    redirect_to statuses_path
  end

  private

  def set_status
    @status = Status.find(params[:id])
  end

  def status_params
    params.require(:status).permit(:github_pr_link, :date, :user_id, :remark_id, tasks_attributes: [:id, :start_time, :end_time, :title, :description, :output_screenshot])
  end

end
