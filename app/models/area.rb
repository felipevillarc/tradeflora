class Area < ApplicationRecord
  belongs_to :user
  belongs_to :basin
  has_one :trade

  include PgSearch::Model
  pg_search_scope :search_by_area_user_or_basin,
                  against: [:description],
                  associated_against: {
                    user: [ :name],
                    basin: [:name]
                  },
                  using: {
                  tsearch: { prefix: true }
                  }

end
