class Connection < ApplicationRecord
  belongs_to :user
  has_many :group_connections, dependent: :destroy
  has_many :groups, through: :group_connections
  has_many :attempts, dependent: :destroy
  paginates_per 10
end
