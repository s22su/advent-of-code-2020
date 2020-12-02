defmodule AdventOfCode.Day02 do
  @moduledoc """
  The shopkeeper at the North Pole Toboggan Rental Shop is having a bad day. "Something's wrong with our computers; we can't log in!" You ask if you can take a look.

  Their password database seems to be a little corrupted: some of the passwords wouldn't have been allowed by the Official Toboggan Corporate Policy that was in effect when they were chosen.

  To try to debug the problem, they have created a list (your puzzle input) of passwords (according to the corrupted database) and the corporate policy when that password was set.
  """

  alias AdventOfCode.Helpers

  @doc """
  Solve the first part of a daily puzzle.

  For example, suppose you have the following list:
  ```
  1-3 a: abcde
  1-3 b: cdefg
  2-9 c: ccccccccc
  ```

  Each line gives the password policy and then the password. The password policy indicates the lowest and highest number of times a given letter must appear for the password to be valid. For example, 1-3 a means that the password must contain a at least 1 time and at most 3 times.

  In the above example, 2 passwords are valid. The middle password, cdefg, is not; it contains no instances of b, but needs at least 1. The first and third passwords are valid: they contain one a or nine c, both within the limits of their respective policies.

  How many passwords are valid according to their policies?

  ## Examples

      iex> input = AdventOfCode.Helpers.read_file("input_data/d02.txt")
      iex> AdventOfCode.Day02.P1.solve_part1(input)
      519
  """
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

  @doc """
  Solve the second part of a daily puzzle.

  While it appears you validated the passwords correctly, they don't seem to be what the Official Toboggan Corporate Authentication System is expecting.

  The shopkeeper suddenly realizes that he just accidentally explained the password policy rules from his old job at the sled rental place down the street! The Official Toboggan Corporate Policy actually works a little differently.

  Each policy actually describes two positions in the password, where 1 means the first character, 2 means the second character, and so on. (Be careful; Toboggan Corporate Policies have no concept of "index zero"!) Exactly one of these positions must contain the given letter. Other occurrences of the letter are irrelevant for the purposes of policy enforcement.

  Given the same example list from above:
    `1-3 a: abcde is valid: position 1 contains a and position 3 does not.`
    `1-3 b: cdefg is invalid: neither position 1 nor position 3 contains b.`
    `2-9 c: ccccccccc is invalid: both position 2 and position 9 contain c.`

  How many passwords are valid according to the new interpretation of the policies?

  ## Examples

      iex> input = AdventOfCode.Helpers.read_file("input_data/d02.txt")
      iex> AdventOfCode.Day02.P1.solve_part2(input)
      519
  """
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
