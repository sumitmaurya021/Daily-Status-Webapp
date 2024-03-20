class Status < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_one_attached :output_screenshot

  # validates :user_id, presence: true
  # validates :github_pr_link, presence: true
  # validates :date, presence: true

  accepts_nested_attributes_for :tasks, allow_destroy: true

  scope :pending, -> { where(status: 'pending') }
  scope :resolved, -> { where(status: 'resolved') }
  scope :issue, -> { where(status: 'issue') }
  scope :completed, -> { where(status: 'completed') }

  def self.pending_count
    pending.count
  end

  def self.resolved_count
    resolved.count
  end

  def self.issue_count
    issue.count
  end

  def self.completed_count
    completed.count
  end

  def self.total_count
    count
  end

end
