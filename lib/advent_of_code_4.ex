defmodule AdventOfCode4 do
  @moduledoc """
  A new system policy has been put in place that requires all accounts to use a passphrase instead of simply a password. 
  A passphrase consists of a series of words (lowercase letters) separated by spaces.

  To ensure security, a valid passphrase must contain no duplicate words.

  For example:

    aa bb cc dd ee is valid.
    aa bb cc dd aa is not valid - the word aa appears more than once.
    aa bb cc dd aaa is valid - aa and aaa count as different words.

  The system's full passphrase list is available as your puzzle input. How many passphrases are valid?
  """

  @doc """

  ## Examples

      iex> AdventOfCode4.valid?("aa bb cc dd ee")
      true
      
      iex> AdventOfCode4.valid?("aa bb cc dd aa")
      false

      iex> AdventOfCode4.valid?("aa bb cc dd aaa")
      true

  """

  def valid?(passphrase) do
    split = passphrase |> String.split(~r{\s})
    Enum.uniq(split) == split
  end

  def how_many_valid(filePath) do
    File.stream!(filePath)
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.filter(&valid?/1)
    |> Enum.to_list()
    |> Enum.count()
  end
end

defmodule AdventOfCode4_2 do
  @moduledoc """
  For added security, yet another system policy has been put in place. 
  Now, a valid passphrase must contain no two words that are anagrams of each other - that is, 
  a passphrase is invalid if any word's letters can be rearranged to form any other word in the passphrase.
  """

  @doc """

  ## Examples

      iex> AdventOfCode4_2.valid?("abcde fghij")
      true

      iex> AdventOfCode4_2.valid?("abcde xyz ecdab")
      false

      iex> AdventOfCode4_2.valid?("a ab abc abd abf abj")
      true

      iex> AdventOfCode4_2.valid?("iiii oiii ooii oooi oooo")
      true

      iex> AdventOfCode4_2.valid?("oiii ioii iioi iiio")
      false

  """

  def valid?(passphrase) do
    split =
      passphrase
      |> String.split(~r{\s})
      |> Enum.map(&sort_string/1)

    Enum.uniq(split) == split
  end

  defp sort_string(str) do
    str
    |> String.graphemes()
    |> Enum.sort()
  end

  def how_many_valid(filePath) do
    File.stream!(filePath)
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.filter(&valid?/1)
    |> Enum.to_list()
    |> Enum.count()
  end
end
