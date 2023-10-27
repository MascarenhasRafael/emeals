require 'test_helper'

class RecipeSerializerTest < ActiveSupport::TestCase
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

    @serializer = RecipeSerializer.new(@recipe)
    @serialized_recipe = @serializer.serializable_hash
  end

  def teardown
    Recipe.destroy_all
  end

  test 'has attributes that match' do
    assert_equal_recipe_attributes(
      id: 1,
      name: 'Brigadeiro',
      image_path: 'https://images.pexels.com/photos/9285194/pexels-photo-9285194.jpeg?auto=compress&cs=tinysrgb&w=1600',
      cook_time_in_seconds: 180,
      prep_time_in_seconds: 60
    )

    assert_equal_instructions([{ id: @recipe.instructions.first.id, content: 'add milk to a clean pan' }])
    assert_equal_ingredients([
      { id: @recipe.ingredients.first.id, item: 'milk', quantity: 1.0, measurement_unit: 'liter' },
      { id: @recipe.ingredients.last.id, item: 'chocolate', quantity: 2.0, measurement_unit: 'spoons' }
    ])
  end

  private

  def assert_equal_recipe_attributes(expected)
    expected.each do |attribute, value|
      assert_equal value, @serialized_recipe[attribute]
    end
  end

  def assert_equal_instructions(expected)
    assert_equal expected, @serialized_recipe[:instructions]
  end

  def assert_equal_ingredients(expected)
    assert_equal expected, @serialized_recipe[:ingredients]
  end
end
