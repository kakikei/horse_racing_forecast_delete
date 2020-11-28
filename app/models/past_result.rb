class PastResult < ApplicationRecord
  belongs_to :house

  validates :ranking, presence: true
  validates :distance, presence: true
  validates :time, presence: true
  validates :horses, presence: true
end
