class PastResult < ApplicationRecord
  has_many :house

  validates :ranking, presence: true
  validates :distance, presence: true
  validates :time, presence: true
  validates :horses, presence: true
end
