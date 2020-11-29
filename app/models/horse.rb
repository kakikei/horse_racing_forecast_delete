class Horse < ApplicationRecord
  has_many :past_resutls
  belongs_to :fathers
  belongs_to :mothers

  validates :name, presence: true
  validates :father, presence: true
  validates :mother, presence: true
end
