class StatusesController < ApplicationController
  before_action :set_status, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :current_user_admin?
  def index
    @user = current_user
    if current_user.admin?
      @statuses = Status.all
    else
      @statuses = current_user.statuses
    end
    @status = Status.new(status: "pending", remarks: nil)
  end

  def show
    @user = current_user
    if @status.nil?
      flash[:alert] = "Status not found"
      redirect_to statuses_path
    end
  end

  def new
    @user = current_user
    @status = Status.new(status: "pending", remarks: nil)
    @users = User.all
  end

  def edit
    @user = current_user
  end

  def create
    @status = Status.new(status_params)
    set_status_attribute
    @status.user = current_user
    if @status.save
      AdminMailer.new_status_email(current_user, @status).deliver_now
      flash[:notice] = "Status created successfully"
      redirect_to status_path(@status)
    else
      render :new, status: :unprocessable_entity
    end
  end


  def update
    set_status_attribute
    if current_user_admin?
      if @status.update(status_params)
        flash[:notice] = 'Status was successfully updated.'
        redirect_to statuses_path
      else
        flash[:alert] = 'Failed to update status.'
        flash[:alert] = @status.errors.full_messages.join(', ')
        render :edit, status: 422
      end
    elsif current_user == @status.user
      if @status.update(status_params)
        flash[:notice] = 'Status was successfully updated.'
        redirect_to statuses_path
      else
        flash[:alert] = 'Failed to update status.'
        flash[:alert] = @status.errors.full_messages.join(', ')
        render :edit, status: 422
      end
    else
      flash[:alert] = 'You do not have permission to update this status.'
      render :edit, status: 422
    end
  end

  def destroy
    @status.destroy
    flash[:notice] = "Status deleted successfully"
    redirect_to statuses_path
  end

  def mark_resolved
    @status = Status.find(params[:id])

    if @status.update(status: "resolved")
      flash[:notice] = "Status updated successfully"
    else
      flash[:alert] = "Failed to mark status as resolved"
    end
    redirect_to statuses_path
  end

  def mark_completed
    @status = Status.find(params[:id])

    if @status.update(status: "completed")
      flash[:notice] = "Status updated successfully"
    else
      flash[:alert] = "Failed to mark status as completed"
    end
    redirect_to statuses_path
  end

  def set_status_attribute
    if current_user.admin?
      @status.status = "issue"
    else
      @status.status = "pending"
    end
  end
  private

  def set_status
    @status = Status.find_by(id: params[:id])
  end

  def status_params
    params.require(:status).permit(:status, :github_pr_link, :date, :user_id, :remarks, tasks_attributes: [:id, :start_time, :end_time, :title, :description, :output_screenshot])
  end

  def current_user_admin?
    current_user.admin?
  end

end
