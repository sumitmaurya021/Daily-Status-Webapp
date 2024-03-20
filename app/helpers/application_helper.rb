# app/helpers/application_helper.rb

module ApplicationHelper

  def employees_present_count
    User.where(role: 'employee').count
  end
  def employee_count
    User.where(role: 'employee').count
  end

  def total_count
    User.count
  end

  def pending_reviews_count
    Status.where(status: 'pending').count
  end

  def resolved_reviews_count
    Status.where(status: 'resolved').count
  end

  def issued_reviews_count
    Status.where(status: 'issue').count
  end

  def completed_reviews_count
    Status.where(status: 'completed').count
  end

  def total_reviews_count
    Status.count
  end

  def current_employees_pending_reviews_count
    current_user.statuses.where(status: 'pending').count
  end

  def current_employees_completed_reviews_count
    current_user.statuses.where(status: 'completed').count
  end

  def current_employees_total_reviews_count
    current_user.statuses.count
  end

  def total_statuses_count
    current_user.statuses.count
  end

  def has_submitted_status_today?
    statuses.exists?(created_at: Date.today.beginning_of_day..Date.today.end_of_day)
  end
end
