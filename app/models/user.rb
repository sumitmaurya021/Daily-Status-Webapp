class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :statuses
  has_many :remarks, through: :statuses
  has_many :checkins
  has_many :checkouts, class_name: 'Checkout'
  has_many :logs


  def admin?
    role == "admin"
  end

  def employee?
    role == "employee"
  end

  def checkin_time
    self.checkin_at
  end

  def has_checked_out_today?
    checkouts.exists?(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

end
