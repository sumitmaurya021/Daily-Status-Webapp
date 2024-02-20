class Task < ApplicationRecord
  has_one_attached :output_screenshot

  belongs_to :status
end
