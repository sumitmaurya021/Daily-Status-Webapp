class Remark < ApplicationRecord
  belongs_to :status

  validates :content, presence: true

  attribute :resolved, :boolean, default: false
end
