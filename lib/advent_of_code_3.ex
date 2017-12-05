defmodule AdventOfCode3 do
  @moduledoc """
  Each square on the grid is allocated in a spiral pattern starting at a location marked 1 and then counting up while spiraling outward. For example, the first few squares are allocated like this:

  17  16  15  14  13
  18   5   4   3  12
  19   6   1   2  11
  20   7   8   9  10
  21  22  23---> ...

  While this is very space-efficient (no squares are skipped), requested data must be carried back to square 1 (the location of the only access port for this memory system) by programs that can only move up, down, left, or right. They always take the shortest path: the Manhattan Distance between the location of the data and square 1.
  """

  @doc """

  ## Examples

      iex> AdventOfCode3.distance(1024)
      31
      iex> AdventOfCode3.distance(12)
      3
      iex> AdventOfCode3.distance(23)
      2
      iex> AdventOfCode3.distance(1)
      0

  """

  def distance(target) do
    navigateTo(target, {1, {0, 0}, :S}, 1, false)
    |> AdventOfCode3_Common.manhattan({0, 0})
  end

  defp navigateTo(target, {current, {x, y}, _}, _, _) when target == current do
    {x, y}
  end

  defp navigateTo(target, {current, {x, y}, dir}, distanceToEdge, turnNow) do
    newDir = AdventOfCode3_Common.turn(dir)
    {xd, yd} = AdventOfCode3_Common.cart(newDir)

    newDistanceToEdge =
      case turnNow do
        true -> distanceToEdge + 1
        false -> distanceToEdge
      end

    c = current + 1
    until = Enum.min([current + distanceToEdge, target])
    steps = c..until |> Enum.to_list()
    at = Enum.reduce(steps, {x, y}, fn _, {xa, ya} -> {xa + xd, ya + yd} end)

    navigateTo(target, {List.last(steps), at, newDir}, newDistanceToEdge, !turnNow)
  end
end

defmodule AdventOfCode3_Common do
  def manhattan({x0, y0}, {x1, y1}) do
    abs(x1 - x0) + abs(y1 - y0)
  end

  def turn(:E), do: :N
  def turn(:N), do: :W
  def turn(:W), do: :S
  def turn(:S), do: :E

  def cart(:E), do: {1, 0}
  def cart(:N), do: {0, 1}
  def cart(:W), do: {-1, 0}
  def cart(:S), do: {0, -1}
end
