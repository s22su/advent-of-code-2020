defmodule AdventOfCode.Day05Test do
  use ExUnit.Case

  describe "parse_pass/1" do
    test "finds a seat for FBFBBFFRLR" do
      assert %{
               id: 44 * 8 + 5,
               row: 44,
               col: 5
             } == AdventOfCode.Day05.parse_pass("FBFBBFFRLR")
    end

    test "finds a seat for BFFFBBFRRR" do
      assert %{
               id: 567,
               row: 70,
               col: 7
             } == AdventOfCode.Day05.parse_pass("BFFFBBFRRR")
    end

    test "finds a seat for FFFBBBFRRR" do
      assert %{
               id: 119,
               row: 14,
               col: 7
             } == AdventOfCode.Day05.parse_pass("FFFBBBFRRR")
    end

    test "finds a seat for BBFFBBFRLL" do
      assert %{
               id: 820,
               row: 102,
               col: 4
             } == AdventOfCode.Day05.parse_pass("BBFFBBFRLL")
    end
  end
end
