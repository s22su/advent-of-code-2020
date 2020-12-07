defmodule AdventOfCode.Day07 do
  def solve_part1(input) do
    preprocess_input(input)
    |> find_bags_containing("shiny gold")
    |> length()
  end

  def solve_part2(input) do
    preprocess_input(input)
    |> sum_bags("shiny gold")
  end

  defp find_bags_containing(all_bags, name) do
    filtered =
      all_bags
      |> Enum.filter(fn bag ->
        Enum.any?(bag.contains, fn %{name: c_name} -> c_name == name end)
      end)

    Enum.reduce(filtered, filtered, fn f, acc ->
      acc ++ find_bags_containing(all_bags, f.name)
    end)
    |> Enum.uniq()
  end

  defp sum_bags(all_bags, initial_bag_name) do
    bag = find_bag(all_bags, initial_bag_name)

    Enum.reduce(bag.contains, 0, fn %{count: count, name: name}, acc ->
      cb = find_bag(all_bags, name)
      # IO.inspect("#{bag.name} contains #{count} x #{cb.name}")

      acc + count * (sum_bags(all_bags, cb.name) + 1)
    end)
  end

  defp find_bag(bags, name) do
    Enum.find(bags, fn bag -> bag.name == name end)
  end

  defp preprocess_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn line ->
      Regex.run(~r/(.*) bags contain (.+)/, line, capture: :all_but_first)
    end)
    |> Enum.map(fn [name, raw_contains] ->
      contains =
        raw_contains
        |> String.replace(["bag", "bags", "."], "")
        |> String.split(",")
        |> Enum.map(&String.trim/1)
        |> Enum.map(fn c ->
          res = Regex.run(~r/(\d+) (.*)/, c, capture: :all_but_first)

          if res do
            %{
              count: Enum.at(res, 0) |> String.to_integer(),
              name: Enum.at(res, 1)
            }
          else
            nil
          end
        end)
        |> Enum.filter(&(!is_nil(&1)))

      [name, contains]
    end)
    |> Enum.map(fn [n, c] -> %{name: n, contains: c} end)
  end
end
