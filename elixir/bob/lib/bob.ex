defmodule Bob do
  def hey(input) do
    input = String.trim(input)
    cond do
      empty?(input) -> "Fine. Be that way!"
      question?(input) && shouting?(input) -> "Calm down, I know what I'm doing!"
      question?(input) -> "Sure."
      shouting?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  def question?(input) do
    cond do
      String.ends_with?(input, "?") -> true
      true -> false
    end
  end

  def shouting?(input) do
    cond do
      String.match?(input, ~r/(?![0-9])[\w]+/u) && String.upcase(input) == input -> true
      true -> false
    end
  end

  def empty?(input), do: String.trim(input) == ""
end
