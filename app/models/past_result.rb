class PastResult < ApplicationRecord
  belongs_to :horse

  validates :ranking, presence: true
  validates :distance, presence: true
  validates :time, presence: true
  validates :horse, presence: true
end
