class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :statuses
  has_many :remarks, through: :statuses


  def admin?
    role == "admin"
  end

  def employee?
    role == "employee"
  end

  after_create :set_default_status

  private

  def set_default_status
    self.statuses.create(status: "Pending")
  end
end
