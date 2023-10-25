class Recipe < ApplicationRecord
  has_many :ingredients, inverse_of: :recipe, dependent: :destroy
  has_many :instructions, inverse_of: :recipe, dependent: :destroy

  accepts_nested_attributes_for :instructions, :ingredients, allow_destroy: true

  validates :name, presence: true

  validates :cook_time_in_seconds,
    :prep_time_in_seconds,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates_associated :instructions, :ingredients
end
