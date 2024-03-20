class UsersController < ApplicationController
  def dashboard
    @user = current_user
    @employees_present_count = User.employee_count
    @total_employees_count = User.total_count
    @pending_reviews_count = Status.pending_count
    @resolved_reviews_count = Status.resolved_count
    @issued_reviews_count = Status.issue_count
    @completed_reviews_count = Status.completed_count
    @total_reviews_count = Status.total_count
    @current_employees_pending_reviews_count = current_user.pending_reviews_count
    @current_employees_completed_reviews_count = current_user.completed_reviews_count
    @current_employees_total_reviews_count = current_user.total_reviews_count
    @logs = Log.all
    @total_statuses_count = current_user.total_statuses_count
  end
end
