class TasksController < ApplicationController
  before_action :set_status, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    redirect_to statuses_path
  end

  def show
    @user = current_user
    if @task.nil?
      flash[:alert] = "Task not found"
      redirect_to tasks_path
    end
  end

  def new
    @user = current_user
  if @status.nil?
    flash[:alert] = "Task not found"
    redirect_to statuses_path
  else
    @task = @status.tasks.build
  end
  end

  def create
    @status = Status.find(params[:status_id])
    @task = @status.tasks.build(task_params)
    if @task.save
      flash[:notice] = "Task created successfully"
      redirect_to status_path(@status)
    else
      flash.now[:alert] = "Failed to create task"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice] = "Task updated successfully"
      redirect_to @task
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = "Task deleted successfully"
    redirect_to tasks_path
  end

  def update_status
    task = Task.new(params[:task_id])
    task.update(status: params[:status])
    head :ok
  end
  private
    def set_task
      @task = Task.find_by(id: params[:id])
    end

    def set_status
      @status = Status.find_by(id: params[:status_id] || params[:id])
      if @status.nil?
        flash[:alert] = "Status not found"
        redirect_to statuses_path
      end
    end
      def task_params
        params.require(:task).permit(:start_time, :end_time, :title, :description, :output_screenshot, :status_id)
      end
end
