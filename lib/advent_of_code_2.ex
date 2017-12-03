defmodule AdventOfCode2 do
  @moduledoc """
  The spreadsheet consists of rows of apparently-random numbers. To make sure the recovery process is on the right track, 
  they need you to calculate the spreadsheet's checksum. 
  For each row, determine the difference between the largest value and the smallest value; the checksum is the sum of all of these differences.
  """

  @doc """

  ## Examples

      iex> AdventOfCode2.checksum([[5, 1, 9, 5],[7, 5, 3],[2, 4, 6, 8]])
      18
  """

  def checksum(sheet) when is_list(sheet) do
    Enum.map(sheet, &minMaxDiff(&1))
    |> Enum.sum()
  end

  def checksum(filePath) do
    File.stream!(filePath)
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&sheetRow(&1))
    |> Enum.to_list()
    |> Enum.sum()
  end

  defp sheetRow(row) do
    String.split(row, ~r{\t})
    |> Enum.map(&String.to_integer/1)
    |> minMaxDiff
  end

  defp minMaxDiff(row) do
    {min, max} = Enum.min_max(row)
    max - min
  end
end

defmodule AdventOfCode2_2 do
  @moduledoc """
  It sounds like the goal is to find the only two numbers in each row where one evenly divides the other - that is, 
  where the result of the division operation is a whole number. 
  They would like you to find those numbers on each line, divide them, and add up each line's result.
  """

  @doc """

  ## Examples

      iex> AdventOfCode2_2.checksum([[5, 9, 2, 8],[9, 4, 7, 3], [3, 8, 6, 5]])
      9
  """

  def checksum(sheet) when is_list(sheet) do
    Enum.map(sheet, &divisors(&1))
    |> Enum.sum()
  end

  def checksum(filePath) do
    File.stream!(filePath)
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&sheetRow(&1))
    |> Enum.to_list()
    |> Enum.sum()
  end

  defp sheetRow(row) do
    String.split(row, ~r{\t})
    |> Enum.map(&String.to_integer/1)
    |> divisors
  end

  defp divisors(row) do
    divisors(Enum.sort(row, &(&1 >= &2)), 0)
  end

  defp divisors([head | tail], 0) do
    reduced = Enum.map tail,  fn t -> divisible(head, t, 0) end
    
    divisors(tail, Enum.sum(reduced))
  end

  defp divisors(_, acc), do: acc

  # defp reduce([], acc), do: acc

  # defp reduce([head | tail], acc) do
    
  # end

  defp divisible(l, r, _) when rem(l, r) == 0 do
    round(l / r)
  end

  defp divisible(_, _, current) do
    current
  end
end
