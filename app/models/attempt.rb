class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :connection
  has_many :guesses, dependent: :destroy
  has_many :solved_groups, dependent: :destroy
  has_many :groups, through: :solved_groups
end
