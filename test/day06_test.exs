defmodule AdventOfCode.Day06Test do
  use ExUnit.Case

  describe "solve_pat1/1" do
    test "solves the puzzle" do
      input = """
      abc

      a
      b
      c

      ab
      ac

      a
      a
      a
      a

      b
      """

      assert 11 == AdventOfCode.Day06.solve_part1(input)
    end
  end

  describe "solve_pat2/1" do
    test "solves the puzzle" do
      input = """
      abc

      a
      b
      c

      ab
      ac

      a
      a
      a
      a

      b
      """

      assert 6 == AdventOfCode.Day06.solve_part2(input)
    end
  end
end
