class Task < ApplicationRecord
  has_one_attached :output_screenshot
  belongs_to :status

  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :description, presence: true
  validates :output_screenshot, presence: true
  validates :status_id, presence: true

end
