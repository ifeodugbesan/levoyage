class Alternative < ApplicationRecord
  belongs_to :user
  belongs_to :issue
  has_rich_text :content
  acts_as_votable
end
