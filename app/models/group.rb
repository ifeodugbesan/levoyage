class Group < ApplicationRecord
  belongs_to :user
  has_many :group_connections, dependent: :destroy
  validates :title, presence: true
  validate :all_four_words

  def all_four_words
    if words.reject(&:blank?).length != 4
      errors.add(:words, "Must add all 4 words")
    end
  end
end
