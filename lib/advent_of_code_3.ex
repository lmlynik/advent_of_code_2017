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

      # iex> AdventOfCode3.distance(1024)
      # 31
      iex> AdventOfCode3.distance(12)
      3
      # iex> AdventOfCode3.distance(23)
      # 2
      # iex> AdventOfCode3.distance(1)
      # 1

  """

  def distance(target) do
    navigateTo(target, {1, {0, 0}, :S}, 1, false)
  end

  defp navigateTo(0, {current, x, y}, _, _) do
    {x, y}
  end

  defp navigateTo(target, {current, {x, y}, dir}, distanceToEdge, turnNow) do
    IO.inspect(Kernel.binding())

    newDir = turn(dir)

    newDistanceToEdge =
      case turnNow do
        true -> distanceToEdge + 1
        false -> distanceToEdge
      end

    {xd, yd} = cart(newDir)

    c = current + 1

    # r =
    #   c..(c + distanceToEdge - 1)
    #   |> Enum.reduce({x, y}, fn _, {x, y} -> {x + xd, y + yd} end)
    #   |> IO.inspect()

    # IO.inspect({r, xd, yd})
    Enum.to_list(c..(c + distanceToEdge - 1)) |> IO.inspect()
    at =
      c..(c + distanceToEdge - 1)
      |> Enum.map(fn i -> {i, {x + xd, y + yd}, newDir} end)
      |> List.last()

    navigateTo(target - 1, at, newDistanceToEdge, !turnNow)
  end

  defp turn(:E), do: :N
  defp turn(:N), do: :W
  defp turn(:W), do: :S
  defp turn(:S), do: :E

  defp cart(:E), do: {1, 0}
  defp cart(:N), do: {0, 1}
  defp cart(:W), do: {-1, 0}
  defp cart(:S), do: {0, -1}
end
