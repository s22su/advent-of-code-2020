defmodule AdventOfCode.Day02 do
  @moduledoc false

  alias AdventOfCode.Helpers

  def solve_part1(input) do
    preprocess_input(input)
    |> Enum.reduce(0, fn record, acc ->
      letter_count = record.password |> String.graphemes() |> Enum.count(&(&1 == record.letter))

      if letter_count >= record.min && letter_count <= record.max do
        acc + 1
      else
        acc
      end
    end)
  end

  def solve_part2(input) do
    preprocess_input(input)
    |> Enum.reduce(0, fn record, acc ->
      pos1 = String.at(record.password, record.min - 1)
      pos2 = String.at(record.password, record.max - 1)

      cond do
        pos1 == record.letter && pos2 == record.letter ->
          acc

        pos1 == record.letter && pos2 !== record.letter ->
          acc + 1

        pos2 == record.letter && pos1 !== record.letter ->
          acc + 1

        true ->
          acc
      end
    end)
  end

  defp preprocess_input(input) do
    input
    |> String.split("\n")
    |> Helpers.trim_lines_and_remove_empty()
    |> Enum.map(fn line ->
      split = String.split(line, " ")
      numbers = Enum.at(split, 0) |> String.split("-")

      %{
        min: Enum.at(numbers, 0) |> String.to_integer(),
        max: Enum.at(numbers, 1) |> String.to_integer(),
        letter: Enum.at(split, 1) |> String.slice(0..0),
        password: Enum.at(split, 2)
      }
    end)
  end
end
