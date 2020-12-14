defmodule AdventOfCode.Day14 do
  def solve_part1(input) do
    preprocess_input(input)
    |> Enum.reduce({nil, %{}}, fn line, {mask, mem} ->
      [cmd, val] = String.split(line, " = ")

      if cmd == "mask" do
        {val, mem}
      else
        addr = String.replace(cmd, ["mem[", "]"], "")
        bin_val = val |> String.to_integer() |> Integer.digits(2)
        padded_bin_val = for i <- 35..0, do: pad_zero(bin_val, i)
        mask_bits = String.graphemes(mask)

        new_val =
          for {bit, i} <- Enum.with_index(padded_bin_val) do
            mask_bit = Enum.at(mask_bits, i)
            get_mask_bit(mask_bit, bit)
          end
          |> Enum.join()
          |> Integer.parse(2)
          |> elem(0)

        {mask, Map.put(mem, addr, new_val)}
      end
    end)
    |> elem(1)
    |> Map.values()
    |> Enum.sum()
  end

  defp pad_zero(bin_val, i), do: Enum.reverse(bin_val) |> Enum.at(i) || 0
  defp get_mask_bit("X", bit), do: bit
  defp get_mask_bit(mask_bit, _), do: String.to_integer(mask_bit)

  def solve_part2(input) do
    preprocess_input(input)
    |> Enum.reduce({nil, %{}}, fn line, {mask, mem} = _acc ->
      [cmd, val] = String.split(line, " = ")

      if cmd == "mask" do
        {val, mem}
      else
        addr = String.replace(cmd, ["mem[", "]"], "") |> String.to_integer()
        int = String.to_integer(val)

        new_mem =
          get_addresses(mask, addr)
          |> Enum.reduce(mem, fn addr, acc ->
            Map.put(acc, addr, int)
          end)

        {mask, new_mem}
      end
    end)
    |> elem(1)
    |> Map.values()
    |> Enum.sum()
  end

  def get_addresses(mask, addr) do
    bits = Integer.digits(addr, 2) |> Enum.reverse()
    mask = String.graphemes(mask) |> Enum.reverse() |> Enum.with_index()

    Enum.reduce(mask, [""], fn {mask_bit, i}, acc ->
      case mask_bit do
        "X" ->
          Enum.reduce(acc, [], fn addr_part, addr_list ->
            addr_list ++ ["0" <> addr_part] ++ ["1" <> addr_part]
          end)

        "0" ->
          Enum.map(acc, fn addr_part ->
            Enum.at(bits, i, 0) |> Integer.to_string() |> Kernel.<>(addr_part)
          end)

        "1" ->
          Enum.map(acc, &("1" <> &1))
      end
    end)
    |> Enum.map(&String.to_integer(&1, 2))
  end

  defp preprocess_input(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
  end
end
