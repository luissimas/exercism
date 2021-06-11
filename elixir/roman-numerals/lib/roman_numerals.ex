defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number, string \\ "")
  def numeral(number, string) when number == 0, do: string

  def numeral(number, string) do
    # Map numeral values
    numerals = [
      %{1000 => "M"},
      %{500 => "D"},
      %{100 => "C"},
      %{50 => "L"},
      %{10 => "X"},
      %{5 => "V"},
      %{1 => "I"}
    ]

  end
end

# IO.puts RomanNumerals.numeral(IO.gets("Number: ") |> String.trim |> String.to_integer)
RomanNumerals.numeral(10)
