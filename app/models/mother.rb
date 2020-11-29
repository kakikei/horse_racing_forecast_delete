class Mother < ApplicationRecord
  has_many :houses
  validates :name, presence: true
end
