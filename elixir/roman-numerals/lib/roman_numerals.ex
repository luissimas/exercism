defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number, string \\ "")

  # Base case
  def numeral(0, string), do: string

  def numeral(number, string) when number >= 1000, do: numeral(number - 1000, string <> "M")
  def numeral(number, string) when number >= 900, do: numeral(number - 900, string <> "CM")
  def numeral(number, string) when number >= 500, do: numeral(number - 500, string <> "D")
  def numeral(number, string) when number >= 490, do: numeral(number - 490, string <> "XD")
  def numeral(number, string) when number >= 400, do: numeral(number - 400, string <> "CD")
  def numeral(number, string) when number >= 100, do: numeral(number - 100, string <> "C")
  def numeral(number, string) when number >= 90, do: numeral(number - 90, string <> "XC")
  def numeral(number, string) when number >= 50, do: numeral(number - 50, string <> "L")
  def numeral(number, string) when number >= 40, do: numeral(number - 40, string <> "XL")
  def numeral(number, string) when number >= 10, do: numeral(number - 10, string <> "X")
  def numeral(number, string) when number >= 9, do: numeral(number - 9, string <> "IX")
  def numeral(number, string) when number >= 5, do: numeral(number - 5, string <> "V")
  def numeral(number, string) when number >= 4, do: numeral(number - 4, string <> "IV")
  def numeral(number, string) when number >= 1, do: numeral(number - 1, string <> "I")
end
