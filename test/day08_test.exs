defmodule AdventOfCode.Day08Test do
  use ExUnit.Case

  describe "solve_pat1/1" do
    test "solves the puzzle" do
      input = """
      nop +0
      acc +1
      jmp +4
      acc +3
      jmp -3
      acc -99
      acc +1
      jmp -4
      acc +6
      """

      assert 5 == AdventOfCode.Day08.solve_part1(input)
    end
  end

  describe "solve_pat2/1" do
    test "solves the puzzle" do
      input = """
      nop +0
      acc +1
      jmp +4
      acc +3
      jmp -3
      acc -99
      acc +1
      jmp -4
      acc +6
      """

      assert 8 == AdventOfCode.Day08.solve_part2(input)
    end
  end
end
