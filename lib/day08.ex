defmodule AdventOfCode.Day08 do
  def solve_part1(input) do
    preprocess_input(input)
    |> apply_instructions(%{sum: 0, done: [], next: 0})
    |> Map.get(:sum)
  end

  def solve_part2(input, prev_replaced \\ 0) do
    instructions = preprocess_input(input)
    {rep, replaced_i} = replace_possible_invalid(instructions, prev_replaced)

    result = apply_instructions(rep, %{sum: 0, done: [], next: 0})

    if result.loop do
      solve_part2(input, replaced_i)
    else
      result.sum
    end
  end

  defp apply_instructions(instructions, acc) do
    {{ins, val}, i} = Enum.at(instructions, acc.next)

    if Enum.member?(acc.done, i) do
      Map.merge(acc, %{loop: true})
    else
      acc =
        case ins do
          "nop" ->
            %{sum: acc.sum, done: acc.done ++ [i], next: acc.next + 1}

          "acc" ->
            %{
              sum: acc.sum + val,
              done: acc.done ++ [i],
              next: acc.next + 1
            }

          "jmp" ->
            %{sum: acc.sum, done: acc.done ++ [i], next: acc.next + val}
        end

      if i == length(instructions) - 1 do
        Map.merge(acc, %{loop: false})
      else
        apply_instructions(instructions, acc)
      end
    end
  end

  defp replace_possible_invalid(instructions, index) do
    {{ins, val}, replaced_i} =
      Enum.find(instructions, fn {{ins, _}, i} ->
        (ins == "nop" || ins == "jmp") && i > index
      end)

    new_ins =
      case ins do
        "jmp" ->
          {{"nop", val}, replaced_i}

        "nop" ->
          {{"jmp", val}, replaced_i}
      end

    {List.replace_at(instructions, replaced_i, new_ins), replaced_i}
  end

  defp preprocess_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn line ->
      [ins, val] = String.split(line, " ")

      {ins, String.to_integer(val)}
    end)
    |> Enum.with_index()
  end
end
