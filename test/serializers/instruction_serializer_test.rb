require 'test_helper'

class InstructionSerializerTest < ActiveSupport::TestCase
  def setup
    @instruction = Instruction.create(
      id: 1,
      content: 'Mix the ingredients'
    )

    @serializer = InstructionSerializer.new(@instruction)
    @serialized_instruction = @serializer.serializable_hash
  end

  def teardown
    Instruction.destroy_all
  end

  test 'has attributes that match' do
    assert_equal_instruction_attributes(
      id: 1,
      content: 'Mix the ingredients'
    )
  end

  private

  def assert_equal_instruction_attributes(expected)
    expected.each do |attribute, value|
      assert_equal value, @serialized_instruction[attribute]
    end
  end
end
