defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  # Function header
  def count(list, count \\ 0)

  # Base case
  def count([], count), do: count

  # Recursive case: just incrementing the
  # counter and passing the tail of the list
  # for the function recursively
  def count([_head | tail], count) do
    count(tail, count + 1)
  end

  @spec reverse(list) :: list
  # Function header
  def reverse(list, acc \\ [])

  # Base case
  def reverse([], acc), do: acc

  # Recursive case: calls itself passing
  # the tail as the remaining list and uses
  # the | operator to prepend the current head
  # of the list on the acc list
  def reverse([head | tail], acc) do
    reverse(tail, [head | acc])
  end

  @spec map(list, (any -> any)) :: list
  # Function header
  def map(list, f)

  # Base case
  def map([], _f), do: []

  # Recursive case: calls itself passing the tail
  # as the list and uses the | operator to prepend
  # the value returned by the function f on the
  # list
  def map([head | tail], f) do
    [f.(head) | map(tail, f)]
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(list, f)

  # Base case
  def filter([], _f), do: []

  # Recursive case
  def filter([head | tail], f) do
    cond do
      f.(head) -> [head | filter(tail, f)]
      true -> filter(tail, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  # Base case (when the list is empty)
  def reduce([], acc, _f), do: acc

  # Recursive case
  def reduce([head | tail], acc, f) do
    reduce(tail, f.(head, acc), f)
  end

  @spec append(list, list) :: list
  # Base cases for empty lists
  def append([], b), do: b
  def append(a, []), do: a

  # Recursive case
  def append([head | tail], b) do
    [head | append(tail, b)]
  end

  @spec concat([[any]]) :: [any]
  # Base case
  def concat([]), do: []

  # In the case that the head list is empty
  def concat([[] | tail]) do
    concat(tail)
  end

  def concat([head | tail]) do
    [hhead | htail] = head
    [hhead | concat([htail | tail])]
  end
end
