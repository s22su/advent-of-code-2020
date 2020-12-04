defmodule AdventOfCode.Day03 do
  @moduledoc """
  NB! This is very unoptimized solution, but as the speed was a factor, I decided to
  multiply map when preprocessing the input! There are more clever ways to do it :)
  """
  alias AdventOfCode.Helpers

  @max_step_right 7

  def solve_part1(input) do
    count_trees(input, right: 3)
  end

  def solve_part2(input) do
    nums = [
      count_trees(input, right: 1, down: 1),
      count_trees(input, right: 3, down: 1),
      count_trees(input, right: 5, down: 1),
      count_trees(input, right: 7, down: 1),
      count_trees(input, right: 1, down: 2)
    ]

    Enum.reduce(nums, 1, fn n, acc -> acc * n end)
  end

  def count_trees(input, opts) do
    preprocess_input(input)
    |> Enum.reduce(0, fn line, acc -> count_single_line(line, acc, opts) end)
  end

  defp count_single_line(line, acc, opts) do
    right = Keyword.get(opts, :right, 1)
    down = Keyword.get(opts, :down, 1)

    {elems, i} = line
    x = floor(i / down * right)

    cond do
      rem(i, down) != 0 ->
        acc

      Enum.at(elems, x) == "#" ->
        acc + 1

      Enum.at(elems, x) == "." ->
        acc

      Enum.at(elems, x) == nil ->
        raise "Adjust the max step!"
    end
  end

  defp preprocess_input(input) do
    lines =
      input
      |> String.split("\n")
      |> Helpers.trim_lines_and_remove_empty()

    lines
    |> Enum.map(fn line ->
      # NB! As I am preparing the map in the beginning, here is the max step that
      # I can take when traveling. If max step is 7 then `right: 8` will fail.
      dup_n = floor(length(lines) / String.length(line)) * (@max_step_right + 1)

      String.duplicate(line, dup_n)
    end)
    |> Enum.map(&String.graphemes/1)
    |> Enum.with_index()
  end
end
