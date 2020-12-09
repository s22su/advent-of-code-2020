defmodule AdventOfCode.Day09Test do
  use ExUnit.Case

  describe "solve_pat1/1" do
    test "solves the puzzle" do
      input = """
      35
      20
      15
      25
      47
      40
      62
      55
      65
      95
      102
      117
      150
      182
      127
      219
      299
      277
      309
      576
      """

      assert 127 == AdventOfCode.Day09.solve_part1(input, 5)
    end
  end

  describe "solve_pat2/1" do
    test "solves the puzzle" do
      input = """
      35
      20
      15
      25
      47
      40
      62
      55
      65
      95
      102
      117
      150
      182
      127
      219
      299
      277
      309
      576
      """

      assert 62 == AdventOfCode.Day09.solve_part2(input, 5)
    end
  end

  describe "solve_part2_with_prefix_sum_list/1" do
    test "solves the puzzle" do
      input = """
      35
      20
      15
      25
      47
      40
      62
      55
      65
      95
      102
      117
      150
      182
      127
      219
      299
      277
      309
      576
      """

      assert 62 == AdventOfCode.Day09.solve_part2_with_prefix_sum_list(input, 5)
    end
  end
end
