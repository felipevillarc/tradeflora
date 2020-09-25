class Basin < ApplicationRecord
  has_many :areas, dependent: :destroy
end
