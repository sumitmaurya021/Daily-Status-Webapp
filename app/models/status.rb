class Status < ApplicationRecord
  belongs_to :employee
  has_many :task
end
