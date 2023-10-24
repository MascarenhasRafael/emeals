class RecipeTest < ActiveSupport::TestCase
  def setup
    @recipe = Recipe.new(
      name: 'Spaghetti Bolognese',
      cook_time_in_seconds: 1800,
      prep_time_in_seconds: 900
    )
  end

  def teardown
    Recipe.destroy_all
  end

  test 'should be valid with valid attributes' do
    assert @recipe.valid?
    assert @recipe.save
  end

  test 'should require name' do
    @recipe.name = nil
    assert_not @recipe.valid?
    assert_includes @recipe.errors[:name], "can't be blank"
    assert_not @recipe.save
  end

  test 'should require cook_time_in_seconds to be present' do
    @recipe.cook_time_in_seconds = nil
    assert_not @recipe.valid?
    assert_includes @recipe.errors[:cook_time_in_seconds], "can't be blank"
    assert_not @recipe.save
  end

  test 'cook_time_in_seconds should be greater than or equal to 0' do
    @recipe.cook_time_in_seconds = -10
    assert_not @recipe.valid?
    assert_includes @recipe.errors[:cook_time_in_seconds], 'must be greater than or equal to 0'
    assert_not @recipe.save
  end

  test 'should require prep_time_in_seconds to be present' do
    @recipe.prep_time_in_seconds = nil
    assert_not @recipe.valid?
    assert_includes @recipe.errors[:prep_time_in_seconds], "can't be blank"
    assert_not @recipe.save
  end

  test 'prep_time_in_seconds should be greater than or equal to 0' do
    @recipe.prep_time_in_seconds = -5
    assert_not @recipe.valid?
    assert_includes @recipe.errors[:prep_time_in_seconds], 'must be greater than or equal to 0'
    assert_not @recipe.save
  end
end
