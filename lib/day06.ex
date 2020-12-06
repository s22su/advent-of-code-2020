defmodule AdventOfCode.Day06 do
  alias AdventOfCode.Helpers

  def solve_part1(input) do
    preprocess_input(input)
    |> Enum.map(fn x -> String.replace(x, "\n", "") end)
    |> Enum.map(fn x -> String.graphemes(x) |> Enum.frequencies() end)
    |> Enum.map(&Kernel.map_size/1)
    |> Enum.sum()
  end

  def solve_part2(input) do
    preprocess_input(input)
    |> Enum.map(fn x -> String.split(x, "\n") end)
    |> Enum.map(fn x -> Enum.map(x, &String.graphemes/1) end)
    |> Enum.map(fn x ->
      Enum.map(x, fn el -> MapSet.new(el) end)
      |> Enum.reduce(fn x, acc -> MapSet.intersection(x, acc) end)
      |> MapSet.size()
    end)
    |> Enum.sum()
  end

  defp preprocess_input(input) do
    input
    |> String.split("\n\n")
    |> Helpers.trim_lines_and_remove_empty()
  end
end
