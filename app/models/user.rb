class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :statuses


  def admin?
    role == "admin"
  end

  def employee?
    role == "employee"
  end

end
