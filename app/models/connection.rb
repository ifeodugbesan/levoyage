class Connection < ApplicationRecord
  belongs_to :user
  has_many :group_connections, dependent: :destroy
  has_many :groups, through: :group_connections
  has_many :attempts, dependent: :destroy
  paginates_per 10

  def complete
    groups.count == 4
  end

  def completed_attempts
    attempts.select { |a| a.completed || a.failed }.size
  end

  def connections_percentage
    @played = completed_attempts
    @wins = attempts.select(&:completed).size
    @wins > 0 ? (@wins / @played.to_f * 100).round : 0
  end
end
