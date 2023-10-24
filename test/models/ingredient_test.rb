class IngredientTest < ActiveSupport::TestCase
  def setup
    @recipe = Recipe.create(
      name: 'Spaghetti Bolognese',
      cook_time_in_seconds: 1800,
      prep_time_in_seconds: 900
    )

    @ingredient = Ingredient.new(
      recipe: @recipe,
      item: 'Tomato Sauce',
      quantity: 1,
      measurement_unit: 'cup'
    )
  end

  def teardown
    Recipe.destroy_all
  end

  test 'should be valid with valid attributes' do
    assert @ingredient.valid?
    assert @ingredient.save
  end

  test 'should require recipe_id' do
    @ingredient.recipe_id = nil
    assert_not @ingredient.valid?
    assert_includes @ingredient.errors[:recipe_id], "can't be blank"
    assert_not @ingredient.save
  end

  test 'should require item' do
    @ingredient.item = nil
    assert_not @ingredient.valid?
    assert_includes @ingredient.errors[:item], "can't be blank"
    assert_not @ingredient.save
  end

  test 'should require quantity' do
    @ingredient.quantity = nil
    assert_not @ingredient.valid?
    assert_includes @ingredient.errors[:quantity], "can't be blank"
    assert_not @ingredient.save
  end

  test 'quantity should be greater than or equal to 0' do
    @ingredient.quantity = -1
    assert_not @ingredient.valid?
    assert_includes @ingredient.errors[:quantity], 'must be greater than or equal to 0'
    assert_not @ingredient.save
  end

  test 'should require measurement_unit' do
    @ingredient.measurement_unit = nil
    assert_not @ingredient.valid?
    assert_includes @ingredient.errors[:measurement_unit], "can't be blank"
    assert_not @ingredient.save
  end

  test 'item should be unique for each recipe' do
    @ingredient.save
    new_ingredient = Ingredient.new(
      recipe_id: @recipe.id,
      item: @ingredient.item,
      quantity: 4,
      measurement_unit: @ingredient.measurement_unit
    )

    assert_not new_ingredient.valid?
    assert_not new_ingredient.save
    assert_includes new_ingredient.errors[:item], 'should be unique for each recipe'

    new_ingredient = Ingredient.new(
      recipe_id: @recipe.id,
      item: 'Spicy Sauce',
      quantity: 1,
      measurement_unit: 'cup'
    )

    assert new_ingredient.valid?
    assert new_ingredient.save
  end
end
