class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :connection
  has_many :guesses
  has_many :solved_groups
  has_many :groups, through: :solved_groups
end
