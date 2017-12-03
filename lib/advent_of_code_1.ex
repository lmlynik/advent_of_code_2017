defmodule AdventOfCode1 do
  @moduledoc """
  The captcha requires you to review a sequence of digits (your puzzle input) and find the sum of all digits that match the next digit in the list. 
  The list is circular, so the digit after the last digit is the first digit in the list.
  """

  @doc """

  ## Examples

      iex> AdventOfCode1.captcha("1122")
      3

      iex> AdventOfCode1.captcha("1234")
      0

      iex> AdventOfCode1.captcha("1111")
      4

      iex> AdventOfCode1.captcha("91212129")
      9
  """
  def captcha(input) do
    [head | _] = chars = input |> String.graphemes()
    (chars ++ [head]) |> solve([])
  end

  def solve([x, x | rest], acc), do: solve([x | rest], [x | acc])
  def solve([_ | rest], acc), do: solve(rest, acc)

  def solve([], acc) do
    acc |> Enum.map(&String.to_integer/1) |> Enum.sum()
  end
end

defmodule AdventOfCode1_2 do
  @moduledoc """
  The captcha requires you to review a sequence of digits (your puzzle input) and find the sum of all digits that match the next digit in the list. 
  The list is circular, so the digit after the last digit is the first digit in the list.
  """

  @doc """

  ## Examples

      iex> AdventOfCode1_2.captcha("1212")
      6

      iex> AdventOfCode1_2.captcha("1221")
      0

      iex> AdventOfCode1_2.captcha("123425")
      4

      iex> AdventOfCode1_2.captcha("123123")
      12

      iex> AdventOfCode1_2.captcha("12131415")
      4
  """
  def captcha(input) do
    chars = input |> String.graphemes()
    hc = (chars |> Enum.count()) / 2 |> round
    list = chars ++ Enum.slice(chars, 0, hc)
    solve(list, [], hc, 0)
  end

  def solve([x | tail], acc, scanOffset, idx) do
    case Enum.at(tail, scanOffset - 1) do
      ^x -> solve(tail, [x | acc], scanOffset, idx + 1)
      _ -> solve(tail, acc, scanOffset, idx + 1)
    end
  end

  def solve([], acc, _, _) do
    acc |> Enum.map(&String.to_integer/1) |> Enum.sum()
  end
end
