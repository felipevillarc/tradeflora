class Area < ApplicationRecord
  belongs_to :user
  belongs_to :basin
  has_one :trade
end
