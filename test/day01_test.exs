defmodule AdventOfCode.Day01.P1Test do
  use ExUnit.Case

  describe "solve_part1/1" do
    test "solves the puzzle" do
      input = "
      1721
      979
      366
      299
      675
      1456
    "

      assert AdventOfCode.Day01.solve_part1(input) == %{
               numbers: [1721, 299],
               answer: 514_579
             }
    end
  end

  describe "solve_part2/1" do
    test "solves the puzzle" do
      input = "
      1721
      979
      366
      299
      675
      1456
    "

      assert AdventOfCode.Day01.solve_part2(input) == %{
               numbers: [979, 366, 675],
               answer: 241_861_950
             }
    end
  end
end
