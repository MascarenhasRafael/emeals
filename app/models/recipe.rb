class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy

  validates :name, presence: true

  validates :cook_time_in_seconds,
    :prep_time_in_seconds,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
