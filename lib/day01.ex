defmodule AdventOfCode.Day01 do
  @moduledoc """
  The tropical island has its own currency and is entirely cash-only. The gold coins used there have a little picture of a starfish; the locals just call them stars. None of the currency exchanges seem to have heard of them, but somehow, you'll need to find fifty of these coins by the time you arrive so you can pay the deposit on your room.

  To save your vacation, you need to get all fifty stars by December 25th.
  """

  alias AdventOfCode.Helpers

  @doc """
  Solves the first part of a daily puzzle.

  Elves need you to find the two entries that sum to 2020 and then multiply those two numbers together.
  For example, suppose your expense report contained the following:
    ```
    1721
    979
    366
    299
    675
    1456
    ```

  In this list, the two entries that sum to 2020 are 1721 and 299.
  Multiplying them together produces 1721 * 299 = 514579, so the correct answer is 514579.

  Of course, your expense report is much larger. Find the two entries that sum to 2020; what do you get if you multiply them together?

  ## Examples

      iex> input = AdventOfCode.Helpers.read_file("input_data/d01.txt")
                  |> AdventOfCode.Helpers.input_string_to_integer_list()
      iex> AdventOfCode.Day01.solve_part1(input)
      %{
        numbers: [1721, 299],
        answer: 514579
      }
  """
  def solve_part1(input) do
    input_with_indexes = preprocess_input(input)

    Enum.reduce_while(input_with_indexes, %{}, fn {num1, i}, acc ->
      List.delete_at(input_with_indexes, i)
      |> sum_and_return_if_match([num1])
      |> continue_or_halt(acc)
    end)
  end

  @doc """
  Solves the second part of a daily puzzle.

  The Elves in accounting are thankful for your help; one of them even offers you a starfish coin they had left over from a past vacation. They offer you a second one if you can find three numbers in your expense report that meet the same criteria.

  Using the above example again, the three entries that sum to 2020 are 979, 366, and 675. Multiplying them together produces the answer, 241861950.

  In your expense report, what is the product of the three entries that sum to 2020?

  ## Examples

      iex> input = AdventOfCode.Helpers.read_file("input_data/d01.txt")
                  |> AdventOfCode.Helpers.input_string_to_integer_list()
      iex> AdventOfCode.Day01.solve_part2(input)
      %{
        numbers: [979, 366, 675],
        answer: 241861950
      }
  """
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
