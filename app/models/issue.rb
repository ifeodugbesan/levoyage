class Issue < ApplicationRecord
  belongs_to :user
  has_rich_text :content
  acts_as_taggable_on :tags
  include PgSearch::Model
  pg_search_scope :search_by_fields,
    against: [ :title, :error_message ],
    associated_against: {
      tags: [ :name ]
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
