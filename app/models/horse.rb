class Horse < ApplicationRecord
  has_many :past_resutls

  validates :name, presence: true
  validates :father, presence: true
  validates :mother, presence: true
end
