class Father < ApplicationRecord
  has_many :horses
  validates :name, presence: true
end
