defmodule AdventOfCode.Helpers do
  @moduledoc """
  Some helpers to read input from files.
  """

  def read_file(path) do
    {:ok, file} = File.read(path)
    file
  end

  def read_input(day) do
    {:ok, file} = File.read("input_data/d#{day}.txt")
    file
  end

  def trim_lines_and_remove_empty(input_list) do
    input_list
    |> Enum.map(&String.trim/1)
    |> Enum.filter(fn el -> el !== "" end)
  end

  def input_string_to_integer_list(input_str) do
    input_str
    |> String.split("\n")
    |> trim_lines_and_remove_empty()
    |> Enum.map(&String.to_integer/1)
  end
end
