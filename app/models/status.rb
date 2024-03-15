class Status < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_one_attached :output_screenshot
  
  # validates :user_id, presence: true
  # validates :github_pr_link, presence: true
  # validates :date, presence: true

  accepts_nested_attributes_for :tasks, allow_destroy: true

end
