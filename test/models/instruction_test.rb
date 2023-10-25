require 'test_helper'

class InstructionTest < ActiveSupport::TestCase
  def setup
    @recipe = Recipe.create(
      name: 'Chicken Alfredo',
      cook_time_in_seconds: 2400,
      prep_time_in_seconds: 900
    )

    @instruction = Instruction.new(
      recipe: @recipe,
      content: 'Cook the chicken and add Alfredo sauce.'
    )
  end

  def teardown
    Recipe.destroy_all
  end

  test 'should be valid with valid attributes' do
    assert @instruction.valid?
    assert @instruction.save
  end

  test 'should require recipe' do
    @instruction.recipe = nil
    assert_not @instruction.valid?
    assert_includes @instruction.errors[:recipe], "can't be blank"
    assert_not @instruction.save
  end

  test 'should require content' do
    @instruction.content = nil
    assert_not @instruction.valid?
    assert_includes @instruction.errors[:content], "can't be blank"
    assert_not @instruction.save
  end

  test 'instruction content should be unique for each recipe' do
    @instruction.save
    new_instruction = Instruction.new(
      recipe_id: @recipe.id,
      content: 'Cook the chicken and add Alfredo sauce.'
    )

    assert_not new_instruction.valid?
    assert_not new_instruction.save
    assert_includes new_instruction.errors[:content], 'should be unique for each recipe'

    new_instruction = Instruction.new(
      recipe_id: @recipe.id,
      content: 'Let the chicken rest for 20 minutes.'
    )

    assert new_instruction.valid?
    assert new_instruction.save
  end
end
