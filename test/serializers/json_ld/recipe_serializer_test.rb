require 'test_helper'
# frozen_string_literal: true

class JsonLd::RecipeSerializerTest < ActiveSupport::TestCase
  def setup
    @recipe = Recipe.create(
      id: 1,
      name: 'Brigadeiro',
      image_path: 'https://images.pexels.com/photos/9285194/pexels-photo-9285194.jpeg?auto=compress&cs=tinysrgb&w=1600',
      cook_time_in_seconds: 180,
      prep_time_in_seconds: 60,
      instructions_attributes: [{ content: 'add milk to a clean pan' }],
      ingredients_attributes: [
        { item: 'milk', quantity: 1.0, measurement_unit: 'liter' },
        { item: 'chocolate', quantity: 2.0, measurement_unit: 'spoons' }
      ]
    )

    @serializer = JsonLd::RecipeSerializer.new(@recipe)
    @serialized_recipe = JSON.parse(@serializer.to_json)
  end

  def teardown
    Recipe.destroy_all
  end

  test 'has attributes that match JSON-LD schema' do
    assert_equal_json_ld_attributes(
      '@context': 'https://schema.org/',
      '@type': 'Recipe',
      '@id': Rails.application.routes.url_helpers.recipe_url(@recipe),
      'name': 'Brigadeiro',
      'image': 'https://images.pexels.com/photos/9285194/pexels-photo-9285194.jpeg?auto=compress&cs=tinysrgb&w=1600',
      'datePublished': formatted_date(@recipe.created_at),
      'prepTime': 'PT1M',
      'cookTime': 'PT3M',
      'totalTime': 'PT4M',
      'recipeIngredient': ['milk, 1 liter', 'chocolate, 2 spoons'],
      'recipeInstructions': [
        { '@type': 'HowToStep', 'position': '1', 'text': 'add milk to a clean pan' }
      ]
    )
  end

  private

  def assert_equal_json_ld_attributes(expected)
    expected.each do |attribute, value|
      assert_equal_value(attribute, value)
    end
  end

  def assert_equal_value(attribute, value)
    if attribute == :datePublished
      assert_equal_dates(value, @serialized_recipe[attribute.to_s])
    elsif value.is_a?(Array) && value.first.is_a?(Hash)
      assert_equal_hashes(value, @serialized_recipe[attribute.to_s])
    else
      assert_equal value, @serialized_recipe[attribute.to_s]
    end
  end

  def assert_equal_dates(expected, actual)
    assert_equal expected, actual
  end

  def assert_equal_hashes(expected, actual)
    handled_hashes = expected.map { |item| item.transform_keys(&:to_s) }
    assert_equal handled_hashes, actual
  end

  def formatted_date(date)
    date.utc.iso8601(3)
  end
end
