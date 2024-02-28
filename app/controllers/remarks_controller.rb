class RemarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_status, only: [:index, :show, :new, :create]
  before_action :authorize_admin!, except: [:index, :show]
  before_action :authorize_employee!, only: [:index, :show]

  def index
    @remarks = @status.remarks
  end

  def show
    @remark = Remark.find(params[:id])
  end

  def new
    @status = Status.find(params[:status_id])
    if @status
      @remark = Remark.new(status: @status)
    else
      flash[:alert] = "Status not found"
      redirect_to statuses_path
    end
  end

  def create
    @status = Status.find(params[:status_id])
    @remark = Remark.new(remark_params)
    @remark.status = @status
    if @remark.save
      flash[:notice] = "Remark created successfully"
      redirect_to status_path(@status)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @remark = @status.remarks.find(params[:id])
  end

  def update
    @remark = @status.remarks.find(params[:id])
    if @remark.update(remark_params)
      flash[:notice] = "Remark updated successfully"
      redirect_to status_remarks_path(@status)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_status
    @status = Status.find(params[:status_id])
  end

  def remark_params
    params.require(:remark).permit(:content, :status_id, :user_id)
  end

  def authorize_admin!
    redirect_to statuses_path, alert: "You are not authorized to perform this action" unless current_user.admin?
  end

  def authorize_employee!
    redirect_to status_remarks_path(@status), alert: "You are not authorized to perform this action" unless current_user.employee?
  end
end
