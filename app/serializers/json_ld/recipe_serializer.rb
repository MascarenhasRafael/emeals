class JsonLd::RecipeSerializer < ActiveModel::Serializer
  def to_json(options = {})
    to_json_ld.to_json(options)
  end

  private

  def to_json_ld
    {
      '@context': 'https://schema.org/',
      '@type': 'Recipe',
      '@id': application_route,
      'name': object.name,
      'image': object.image_path,
      'dateCreated': object.created_at,
      'dateModified': object.updated_at,
      'prepTime': parse_time(object.prep_time_in_seconds),
      'cookTime': parse_time(object.cook_time_in_seconds),
      'totalTime': total_time,
      'recipeIngredient': ingredients,
      'recipeInstructions': instructions
    }
  end

  def application_route
    Rails.application.routes.url_helpers.recipe_url(object)
  end

  def format_quantity(quantity)
    quantity.to_i.to_f == quantity.to_f ? quantity.to_i : quantity
  end

  def ingredients
    object.ingredients.map do |ingredient|
      formatted_quantity = format_quantity(ingredient.quantity)
      "#{ingredient.item}, #{formatted_quantity} #{ingredient.measurement_unit}"
    end
  end

  def instructions
    object.instructions.map.with_index(1) do |step, position|
      { '@type': 'HowToStep', 'position': position.to_s, 'text': step.content }
    end
  end

  def total_time
    parse_time(object.prep_time_in_seconds + object.cook_time_in_seconds)
  end

  def parse_time(time_in_seconds)
    ActiveSupport::Duration.build(time_in_seconds).iso8601
  end
end
