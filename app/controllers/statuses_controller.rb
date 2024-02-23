class StatusesController < ApplicationController
  before_action :set_status, only: [:show, :edit, :update, :destroy]
  def index
    @statuses = Status.all
  end

  def show
  end

  def new
    @status = current_user.statuses.build
  end

  def create
    @status = current_user.statuses.build(status_params)
    if @status.save
      flash[:notice] = "Status created successfully"
      redirect_to @status
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
    params.require(:status).permit(:github_pr_link)
  end

end
