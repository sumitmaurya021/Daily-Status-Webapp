class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:index, :destroy]
  skip_before_action :authenticate_employee!, only: [:new, :create]

  def index
    @employees = Employee.all
  end

  def show
    @statuses = @employee.statuses.order(created_at: :desc)
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      flash[:notice] = "Employee created successfully"
      redirect_to employee_path(@employee)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      flash[:notice] = "Employee updated successfully"
      redirect_to @employee
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    flash[:notice] = "Employee deleted successfully"
    redirect_to employees_path
  end

  def filter_by_date
    date = Date.parse(params[:date])
    @statuses = @employee.statuses.where(created_at: date.all_day)
    render :show
  end

  def filter_by_year
    year = params[:year].to_i
    @statuses = @employee.statuses.where("extract(year from created_at) = ?", year)
    render :show
  end

  def filter_by_month
    year = params[:year].to_i
    month = params[:month].to_i
    @statuses = @employee.statuses.where("extract(year from created_at) = ? AND extract(month from created_at) = ?", year, month)
    render :show
  end

  def resolve_remarks
    @status = Status.find(params[:id])
    @status.update(remarks: nil)
    StatusMailer.status_resolved_notification(@status).deliver_now
    redirect_to @status, notice: 'Remarks resolved successfully.'
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :password, :admin)
  end

  def require_admin
    redirect_to root_path unless current_employee && current_employee.admin?
  end
end
