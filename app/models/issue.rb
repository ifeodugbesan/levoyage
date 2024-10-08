class Issue < ApplicationRecord
  belongs_to :user
  has_many :alternatives
  has_rich_text :content
  acts_as_taggable_on :tags
  acts_as_votable
  paginates_per 10
  extend FriendlyId
  friendly_id :title, use: :slugged
  include PgSearch::Model
  pg_search_scope :search_by_fields,
    against: [ :title, :error_message ],
    associated_against: {
      tags: [ :name ]
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
  validates :title, presence: true
  validates :content, presence: true
end
