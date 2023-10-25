class Instruction < ApplicationRecord
  belongs_to :recipe

  validates :recipe, presence: true

  validates :content,
    uniqueness: { scope: :recipe_id, message: "should be unique for each recipe" },
    presence: true
end
