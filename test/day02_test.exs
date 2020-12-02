defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  describe "solve_part1/1" do
    test "solves the puzzle" do
      input = "
        1-3 a: abcde
        1-3 b: cdefg
        2-9 c: ccccccccc
      "

      assert AdventOfCode.Day02.solve_part1(input) == 2
    end
  end

  describe "solve_part2/1" do
    test "solves the puzzle" do
      input = "
      1-3 a: abcde
      1-3 b: cdefg
      2-9 c: ccccccccc
    "

      assert AdventOfCode.Day02.solve_part2(input) == 1
    end

    test "solves the puzzle with some more complicated cases" do
      input = "
      1-3 a: abade
      1-3 a: abcade
      1-3 a: abcde
      1-3 b: cdefg
      2-9 c: ccccccccc
    "

      assert AdventOfCode.Day02.solve_part2(input) == 2
    end
  end
end
