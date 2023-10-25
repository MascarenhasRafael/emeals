class Instruction < ApplicationRecord
  belongs_to :recipe

  validates :recipe_id, presence: true

  validates :content,
    uniqueness: { scope: :recipe_id, message: "should be unique for each recipe" },
    presence: true
end
