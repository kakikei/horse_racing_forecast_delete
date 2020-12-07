class Average < ApplicationRecord
  belongs_to :horse

  validates :horse, presence: true
  validates :match_day, presence: true
end
