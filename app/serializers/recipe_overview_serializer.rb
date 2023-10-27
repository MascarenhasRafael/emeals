class RecipeOverviewSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_path, :updated_at
end
