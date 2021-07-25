defmodule Zipper do
  @type t :: %Zipper{path: path(), focus: BinTree.t()}
  @type path :: %{direction: :right | :left, parent: t() | nil} | nil

  defstruct [:path, :focus]

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree) do
    %Zipper{path: nil, focus: bin_tree}
    |> check_end()
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(%{path: nil, focus: focus}), do: focus

  def to_tree(zipper) do
    zipper
    |> up()
    |> to_tree()
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(nil), do: nil

  def value(zipper) do
    zipper.focus.value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(zipper) do
    %Zipper{
      path: %{direction: :left, parent: zipper},
      focus: zipper.focus.left
    }
    |> check_end()
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(zipper) do
    %Zipper{
      path: %{direction: :right, parent: zipper},
      focus: zipper.focus.right
    }
    |> check_end()
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(%{path: nil}), do: nil

  def up(zipper) do
    zipper.path.parent
    |> check_end()
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(zipper, value) do
    update_value(zipper, value, :value)
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper, left) do
    update_value(zipper, left, :left)
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper, right) do
    update_value(zipper, right, :right)
  end

  @spec check_end(Zipper.t()) :: Zipper.t() | nil
  defp check_end(%{focus: nil}), do: nil
  defp check_end(zipper), do: zipper

  @spec update_value(Zipper.t(), any, atom()) :: Zipper.t()
  defp update_value(zipper, value, direction) when zipper.path == nil do
    new_focus = Map.put(zipper.focus, direction, value)

    %{zipper | focus: new_focus}
  end

  defp update_value(zipper, value, direction) do
    new_focus = Map.put(zipper.focus, direction, value)
    new_parent_focus = Map.put(zipper.path.parent.focus, zipper.path.direction, new_focus)
    new_parent = Map.put(zipper.path.parent, :focus, new_parent_focus)

    %Zipper{focus: new_focus, path: %{zipper.path | parent: new_parent}}
  end
end
