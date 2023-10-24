class Ingredient < ApplicationRecord
  belongs_to :recipe

  validates :recipe_id, :measurement_unit, presence: true

  validates :item,
    uniqueness: { scope: :recipe_id, message: "should be unique for each recipe" },
    presence: true

  validates :quantity,
    presence: true,
    numericality: { greater_than_or_equal_to: 0 }
end
