require 'test_helper'

class IngredientSerializerTest < ActiveSupport::TestCase
  def setup
    @ingredient = Ingredient.create(
      id: 1,
      item: 'Sugar',
      quantity: 2.5,
      measurement_unit: 'cups'
    )

    @serializer = IngredientSerializer.new(@ingredient)
    @serialized_ingredient = @serializer.serializable_hash
  end

  def teardown
    Ingredient.destroy_all
  end

  test 'has attributes that match' do
    assert_equal_ingredient_attributes(
      id: 1,
      item: 'Sugar',
      quantity: 2.5,
      measurement_unit: 'cups'
    )
  end

  private

  def assert_equal_ingredient_attributes(expected)
    expected.each do |attribute, value|
      assert_equal value, @serialized_ingredient[attribute]
    end
  end
end
