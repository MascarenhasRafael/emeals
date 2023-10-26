class IngredientSerializer < ActiveModel::Serializer
  attributes :id, :item, :quantity, :measurement_unit
end
