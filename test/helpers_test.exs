defmodule AdventOfCode.HelpersTest do
  use ExUnit.Case

  alias AdventOfCode.Helpers

  test "input_string_to_integer_list/1" do
    input = "
      1721
      979
      366
      299
      675
      1456
    "

    assert Helpers.input_string_to_integer_list(input) == [1721, 979, 366, 299, 675, 1456]
  end
end
