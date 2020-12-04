defmodule AdventOfCode.Day04 do
  alias AdventOfCode.Helpers

  @required_keys [
    :byr,
    :iyr,
    :eyr,
    :hgt,
    :hcl,
    :ecl,
    :pid
  ]

  def solve_part1(input) do
    preprocess_input(input)
    |> Enum.reduce(0, fn passport, acc ->
      if Enum.all?(@required_keys, &Map.has_key?(passport, &1)) do
        acc + 1
      else
        acc
      end
    end)
  end

  def solve_part2(input) do
    preprocess_input(input)
    |> Enum.reduce(0, fn passport, acc ->
      if Enum.all?(@required_keys, &Map.has_key?(passport, &1)) &&
           passport_data_valid?(passport) do
        acc + 1
      else
        acc
      end
    end)
  end

  defp passport_data_valid?(passport) do
    # byr (Birth Year) - four digits; at least 1920 and at most 2002.
    byr = Map.get(passport, :byr) |> String.to_integer()
    byr_valid = byr >= 1920 && byr <= 2020

    # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
    iyr = Map.get(passport, :iyr) |> String.to_integer()
    iyr_valid = iyr >= 2010 && iyr <= 2020

    # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
    eyr = Map.get(passport, :eyr) |> String.to_integer()
    eyr_valid = eyr >= 2020 && eyr <= 2030

    # hgt (Height) - a number followed by either cm or in:
    #  If cm, the number must be at least 150 and at most 193.
    #  If in, the number must be at least 59 and at most 76.
    hgt = Map.get(passport, :hgt)
    hgt_unit = String.slice(hgt, String.length(hgt) - 2, 2)
    hgt_without_unit = String.replace(hgt, hgt_unit, "")

    hgt_valid =
      cond do
        hgt_unit == "cm" ->
          String.to_integer(hgt_without_unit) >= 150 && String.to_integer(hgt_without_unit) <= 193

        hgt_unit == "in" ->
          String.to_integer(hgt_without_unit) >= 59 && String.to_integer(hgt_without_unit) <= 76

        true ->
          false
      end

    # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    hcl = Map.get(passport, :hcl)
    hcl_valid = String.match?(hcl, ~r/^#[0-9a-f]{6}$/)

    # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    ecl = Map.get(passport, :ecl)
    ecl_valid = Enum.any?(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"], fn x -> ecl == x end)

    # pid (Passport ID) - a nine-digit number, including leading zeroes.
    pid = Map.get(passport, :pid)
    pid_valid = String.match?(pid, ~r/^[0-9]{9}$/)

    byr_valid && iyr_valid && eyr_valid && hgt_valid && hcl_valid && ecl_valid && pid_valid
  end

  defp preprocess_input(input) do
    input
    |> String.split("\n\n")
    |> Helpers.trim_lines_and_remove_empty()
    |> Enum.map(fn line -> String.split(line, [" ", "\n"]) end)
    |> Enum.map(fn attributes ->
      Enum.reduce(attributes, %{}, fn attribute, acc ->
        kv = String.split(attribute, ":")

        if Enum.at(kv, 0) !== "" do
          Map.put(acc, :"#{Enum.at(kv, 0)}", String.trim(Enum.at(kv, 1)))
        else
          acc
        end
      end)
    end)
  end
end
