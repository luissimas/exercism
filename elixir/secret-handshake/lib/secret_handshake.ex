defmodule SecretHandshake do
  use Bitwise, only_operators: true

  @wink 1
  @double_blink 2
  @close_your_eyes 4
  @jump 8
  @reverse 16

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code, acc \\ [])

  def commands(0, acc), do: acc

  def commands(code, acc) do
    {value, event} = command(code)

    case value do
      @reverse -> commands(code - value, Enum.reverse(acc))
      _ -> commands(code - value, acc ++ event)
    end
  end

  defp command(code) when (code &&& @wink) == @wink, do: {@wink, ["wink"]}

  defp command(code) when (code &&& @double_blink) == @double_blink,
    do: {@double_blink, ["double blink"]}

  defp command(code) when (code &&& @close_your_eyes) == @close_your_eyes,
    do: {@close_your_eyes, ["close your eyes"]}

  defp command(code) when (code &&& @jump) == @jump, do: {@jump, ["jump"]}

  defp command(code) when (code &&& @reverse) == @reverse, do: {@reverse, []}

  defp command(code), do: {code, []}
end
