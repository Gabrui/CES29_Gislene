class Point < ApplicationRecord
  validates :lat, presence: true
  validates :lon, presence: true
end
