class UsersController < ApplicationController
  def dashboard
    @user = current_user
    @employees_present_count = User.where(role: 'employee').count
    @total_employees_count = User.count
    @pending_reviews_count = Status.where(status: 'pending').count
    @completed_reviews_count = Status.where(status: 'completed').count
    @total_reviews_count = Status.count
    employee_id = current_user.id
    @current_employees_pending_reviews_count = Status.where(user_id: employee_id, status: 'pending').count
    @current_employees_completed_reviews_count = Status.where(user_id: employee_id, status: 'completed').count
    @current_employees_total_reviews_count = Status.where(user_id: employee_id).count
    @logs = Log.all
    @total_statuses_count = current_user.statuses.count
  end
end
