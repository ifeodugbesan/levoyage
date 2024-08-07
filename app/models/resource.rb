class Resource < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  acts_as_taggable_on :tags
  acts_as_votable
  paginates_per 10
  include PgSearch::Model
  pg_search_scope :search_by_title_and_description,
                  against: [:title, :description],
                  using: {
                    tsearch: { prefix: true }
                  }
end
