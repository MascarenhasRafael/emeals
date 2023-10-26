class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_path, :cook_time_in_seconds, :prep_time_in_seconds

  has_many :instructions
  has_many :ingredients
end
