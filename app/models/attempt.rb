class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :connection
  has_many :guesses
end
