defmodule AdventOfCode.Day03Test do
  use ExUnit.Case

  setup_all do
    input = "
    ..##.......
    #...#...#..
    .#....#..#.
    ..#.#...#.#
    .#...##..#.
    ..#.##.....
    .#.#.#....#
    .#........#
    #.##...#...
    #...##....#
    .#..#...#.#
    "

    {:ok, input: input}
  end

  describe "solve_part1/1" do
    test "solves the puzzle", %{input: input} do
      assert AdventOfCode.Day03.solve_part1(input) == 7
    end
  end

  describe "solve_part2/1" do
    test "solves the puzzle", %{input: input} do
      assert AdventOfCode.Day03.solve_part2(input) == 336
    end
  end

  describe "count_trees/2" do
    test "counts trees correctly", %{input: input} do
      assert AdventOfCode.Day03.count_trees(input, right: 1, down: 1) == 2
      assert AdventOfCode.Day03.count_trees(input, right: 3, down: 1) == 7
      assert AdventOfCode.Day03.count_trees(input, right: 5, down: 1) == 3
      assert AdventOfCode.Day03.count_trees(input, right: 7, down: 1) == 4
      assert AdventOfCode.Day03.count_trees(input, right: 1, down: 2) == 2
    end
  end
end
