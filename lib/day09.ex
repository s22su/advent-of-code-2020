defmodule AdventOfCode.Day09 do
  def solve_part1(input, preamble_size \\ 25) do
    preprocess_input(input)
    |> find_invalid(preamble_size)
  end

  def solve_part2(input, preamble_size \\ 25) do
    numbers = preprocess_input(input)

    find_subset(numbers, solve_part1(input, preamble_size))
    |> Enum.min_max()
    |> Tuple.to_list()
    |> Enum.sum()
  end

  def find_subset(numbers, expected_sum) do
    {subset, sum} =
      Enum.reduce_while(numbers, {[], 0}, fn n, {sub, acc} ->
        sum = n + acc

        if sum < expected_sum do
          # the sequence of numbers doesn't really matter so can prepend element
          # {:cont, {sub ++ [n], sum}}
          {:cont, {[n | sub], sum}}
        else
          # {:halt, {sub ++ [n], sum}}
          # the sequence of numbers doesn't really matter so can prepend element
          {:halt, {[n | sub], sum}}
        end
      end)

    if sum == expected_sum do
      subset
    else
      find_subset(tl(numbers), expected_sum)
    end
  end

  def find_invalid(numbers, preamble_size) do
    preamble = Enum.take(numbers, preamble_size)
    numbers = Enum.drop(numbers, preamble_size)

    Enum.reduce_while(numbers, {numbers, preamble}, fn n, {numbers, preamble} ->
      if sum_of_any2?(preamble, n) do
        {:cont, {tl(numbers), tl(preamble) ++ [n]}}
      else
        {:halt, n}
      end
    end)
  end

  defp sum_of_any2?(preamble, expected_sum) do
    for n1 <- preamble, n2 <- preamble do
      n1 != n2 && n1 + n2 == expected_sum
    end
    |> Enum.any?(fn v -> v == true end)
  end

  defp preprocess_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
