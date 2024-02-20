class Status < ApplicationRecord
  belongs_to :employee
  has_many :tasks
end
