class Connection < ApplicationRecord
  belongs_to :user
  has_many :group_connections
  has_many :groups, through: :group_connections
end
