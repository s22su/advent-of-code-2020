defmodule AdventOfCode.Day05 do
  alias AdventOfCode.Helpers

  def solve_part1() do
    Helpers.read_file("input_data/d05.txt")
    |> String.split("\n")
    |> Helpers.trim_lines_and_remove_empty()
    |> Enum.map(&parse_pass/1)
    |> Enum.max_by(fn %{id: id} -> id end)
  end

  def solve_part2() do
    Helpers.read_file("input_data/d05.txt")
    |> String.split("\n")
    |> Helpers.trim_lines_and_remove_empty()
    |> Enum.map(&parse_pass/1)
    |> Enum.map(fn %{id: id} -> id end)
    |> Enum.sort()
    |> find_empty_seat()
  end

  def parse_pass(<<row::binary-size(7), col::binary-size(3)>>) do
    row =
      Enum.to_list(0..127)
      |> Enum.map(&Integer.to_string/1)
      |> find_row_or_col(row)
      |> String.to_integer()

    col =
      Enum.to_list(0..7)
      |> Enum.map(&Integer.to_string/1)
      |> find_row_or_col(col)
      |> String.to_integer()

    %{row: row, col: col, id: row * 8 + col}
  end

  defp find_empty_seat([a, b | rest]) when b == a + 1, do: find_empty_seat([b | rest])
  defp find_empty_seat([a | _]), do: a + 1

  defp find_row_or_col(curr, instructions) do
    {ins, leftover} = String.graphemes(instructions) |> List.pop_at(0)

    n = round(length(curr) / 2)

    new =
      cond do
        ins == "F" || ins == "L" ->
          Enum.take(curr, n)

        ins == "B" || ins == "R" ->
          Enum.take(curr, n * -1)
      end

    if length(new) == 1 do
      Enum.at(new, 0)
    else
      find_row_or_col(new, Enum.join(leftover))
    end
  end
end
