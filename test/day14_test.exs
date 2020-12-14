defmodule AdventOfCode.Day14Test do
  use ExUnit.Case

  describe "solve_part1/1" do
    test "solves the puzzle" do
      input = """
      mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
      mem[8] = 11
      mem[7] = 101
      mem[8] = 0
      """

      assert 165 == AdventOfCode.Day14.solve_part1(input)
    end
  end

  describe "solve_part2/1" do
    test "solves the puzzle" do
      input = """
      mask = 000000000000000000000000000000X1001X
      mem[42] = 100
      mask = 00000000000000000000000000000000X0XX
      mem[26] = 1
      """

      assert 208 == AdventOfCode.Day14.solve_part2(input)
    end
  end
end
