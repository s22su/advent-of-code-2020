defmodule AdventOfCode.Day01 do
  @moduledoc false

  alias AdventOfCode.Helpers

  def solve_part1(input) do
    input_with_indexes = preprocess_input(input)

    Enum.reduce_while(input_with_indexes, %{}, fn {num1, i}, acc ->
      List.delete_at(input_with_indexes, i)
      |> sum_and_return_if_match([num1])
      |> continue_or_halt(acc)
    end)
  end

  def solve_part2(input) do
    input_with_indexes = preprocess_input(input)

    Enum.reduce_while(input_with_indexes, %{}, fn {num1, i}, acc ->
      List.delete_at(input_with_indexes, i)
      |> Enum.reduce_while(%{}, fn {num2, i2}, acc2 ->
        input_with_indexes
        |> List.delete_at(i)
        |> List.delete_at(i2)
        |> sum_and_return_if_match([num1, num2])
        |> continue_or_halt(acc2)
      end)
      |> continue_or_halt(acc)
    end)
  end

  defp sum_and_return_if_match(input_without_self, nums) do
    current_sum = Enum.sum(nums)

    Enum.reduce_while(input_without_self, %{}, fn {current_number, _}, acc ->
      if current_number + current_sum === 2020 do
        all_numbers = nums ++ [current_number]

        {:halt,
         %{
           numbers: all_numbers,
           answer: Enum.reduce(all_numbers, 1, fn num, acc -> num * acc end)
         }}
      else
        {:cont, acc}
      end
    end)
  end

  defp continue_or_halt(result, acc) do
    if Enum.empty?(result) do
      {:cont, acc}
    else
      {:halt, result}
    end
  end

  defp preprocess_input(input) do
    input
    |> Helpers.input_string_to_integer_list()
    |> Enum.with_index()
  end
end
