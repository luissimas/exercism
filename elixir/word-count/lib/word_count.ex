defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase
    |> String.split(~r/[\s\_]/) # Splits the string on whitespaces and underscores
    |> Enum.map(fn word -> String.replace(word, ~r/[^\w\-]/u, "") end) # Removes all the non-word characters
    |> Enum.reject(fn word -> word == "" end) # Removes all empty strings
    |> Enum.reduce(%{}, fn word, acc -> Map.put acc, word, (Map.get(acc, word, 0) + 1)  end)
  end
end
