defmodule AdventOfCode5 do
  @moduledoc """
  The message includes a list of the offsets for each jump. Jumps are relative: -1 moves to the previous instruction, and 2 skips the next one. 
  Start at the first instruction in the list. The goal is to follow the jumps until one leads outside the list.

  In addition, these instructions are a little strange; after each jump, the offset of that instruction increases by 1.
  So, if you come across an offset of 3, you would move three instructions forward, but change it to a 4 for the next time it is encountered.

  """

  @doc """

  ## Examples

      iex> AdventOfCode5.steps([0,3,0,1,-3])
      {5,  [2, 5, 0, 1, -2]}

  """

  def steps(registers) do
    steps(registers, 0, 0)
  end

  defp steps(registers, idx, acc) do
    case Enum.fetch(registers, idx) do
      {:ok, value} -> 
        registers = List.update_at(registers, idx, fn x -> x + 1 end)
        steps(registers, idx + value, acc + 1)
      :error -> {acc, registers}
    end
  end

  def from_file(filePath) do
    File.stream!(filePath)
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list()
    |> steps()
  end

end

defmodule AdventOfCode5_2 do
  @moduledoc """
  Now, the jumps are even stranger: after each jump, if the offset was three or more, instead decrease it by 1.
  Otherwise, increase it by 1 as before.

  Using this rule with the above example, the process now takes 10 steps, and the offset values after finding the exit are left as 2 3 2 3 -1.

  How many steps does it now take to reach the exit?
  """

  @doc """

  ## Examples

      iex> AdventOfCode5_2.steps([0,3,0,1,-3])
      {10, [2, 3, 2, 3, -1]}

  """

  def steps(registers) do
    steps(registers, 0, 0)
  end

  defp steps(registers, idx, acc) do
    case Enum.fetch(registers, idx) do
      {:ok, value} when value >= 3 -> 
        registers = List.update_at(registers, idx, fn x -> x - 1 end)
        steps(registers, idx + value, acc + 1)
      {:ok, value} -> 
        registers = List.update_at(registers, idx, fn x -> x + 1 end)
        steps(registers, idx + value, acc + 1)
      :error -> {acc, registers}
    end
  end

  def from_file(filePath) do
    File.stream!(filePath)
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list()
    |> steps()
  end

end
