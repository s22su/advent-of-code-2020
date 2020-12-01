defmodule AdventOfCode.Helpers do
  @moduledoc """
  Some helpers to read input from files.
  """

  def read_file(path) do
    {:ok, file} = File.read(path)
    file
  end

  def input_string_to_integer_list(input_str) do
    input_str
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.filter(fn el -> el !== "" end)
    |> Enum.map(&String.to_integer/1)
  end
end
