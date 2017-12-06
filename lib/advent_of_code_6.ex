defmodule AdventOfCode6 do
  @moduledoc """
  """

  @doc """

  ## Examples

      iex> AdventOfCode6.max_index([0, 2, 7, 0])
      {7 , 2}

      iex> AdventOfCode6.max_index([0, 7, 2 , 3, 3, 7, 0])
      {7 , 1}

      iex> AdventOfCode6.balance([0, 2, 7, 0])
      5
      iex> AdventOfCode6.balance([10,	3,	15,	10,	5,	15,	5,	15,	9,	2,	5,	8,	5,	2,	3,	6])
      14029
      iex> AdventOfCode6.loop_length([10,	3,	15,	10,	5,	15,	5,	15,	9,	2,	5,	8,	5,	2,	3,	6])
      2765
  """

  def balance(memory_banks) do
    balance(memory_banks, [], 0, fn _, it -> it end)
  end

  def loop_length(memory_banks) do
    {loop_stopper, seen} = balance(memory_banks, [], 0, fn x, _ -> x end)
    Enum.find_index(seen, fn f -> f === loop_stopper end) + 1
  
  end

  defp balance(current_memory_banks, seen, it, on_finished) do
    already_seen = Enum.member?(seen, current_memory_banks)
    

    if already_seen do
      on_finished.({current_memory_banks,seen}, it)
    else
      {v, i} =
        current_memory_banks
        |> max_index

      to_balance = List.update_at(current_memory_banks, i, fn _ -> 0 end)
      balance(redistribute({v, i + 1}, to_balance), [current_memory_banks | seen], it + 1, on_finished)
    end
  end

  def redistribute({0, _}, memory_banks), do: memory_banks

  def redistribute({to_redistribute, processed}, memory_banks)
      when length(memory_banks) <= processed do
    redistribute({to_redistribute, 0}, memory_banks)
  end

  def redistribute({to_redistribute, processed}, memory_banks) do
    new_memory_banks = List.update_at(memory_banks, processed, fn x -> x + 1 end)
    redistribute({to_redistribute - 1, processed + 1}, new_memory_banks)
  end

  def max_index([head | tail]), do: max_index(tail, {head, 0}, 1)

  defp max_index([], acc, _), do: acc

  defp max_index([head | tail], {v, _}, idx) when v < head do
    max_index(tail, {head, idx}, idx + 1)
  end

  defp max_index([head | tail], {v, i}, idx) when v > head do
    max_index(tail, {v, i}, idx + 1)
  end

  defp max_index([head | tail], {v, i}, idx) when v == head and idx > i do
    max_index(tail, {v, i}, idx + 1)
  end

  defp max_index([head | tail], {v, i}, idx) when v == head and idx < i do
    max_index(tail, {head, idx}, idx + 1)
  end
end
