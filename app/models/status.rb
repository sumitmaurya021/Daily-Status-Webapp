class Status < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  # validates :remarks, presence: true
  validates :user_id, presence: true
  validates :github_pr_link, presence: true
  validates :date, presence: true
  has_many :remarks, dependent: :destroy
  accepts_nested_attributes_for :tasks, allow_destroy: true

  def status
    if remarks.present? # Check if there are any remarks associated with the status
      "Resolved" # If there are remarks, consider the status as "Resolved"
    else
      "Pending" # If there are no remarks, consider the status as "Pending"
    end
  end

  attribute :status, :string

  def all_remarks_resolved?
    remarks.all?(&:resolved?)
  end

end
