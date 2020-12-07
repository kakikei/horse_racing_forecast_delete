class Horse < ApplicationRecord
  has_many :past_resutls
  has_many :averages
  belongs_to :father
  belongs_to :mother

  validates :name, presence: true
  validates :father, presence: true
  validates :mother, presence: true
end
