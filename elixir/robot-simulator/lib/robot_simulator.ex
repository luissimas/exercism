defmodule RobotSimulator do
  @directions [:north, :east, :south, :west]
  defstruct direction: :north, position: {0, 0}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ nil, position \\ nil)

  # Default values
  def create(nil, nil) do
    %RobotSimulator{}
  end

  def create(direction, _position) when direction not in @directions do
    {:error, "invalid direction"}
  end

  def create(direction, {x, y}) when is_number(x) and is_number(y) do
    %RobotSimulator{direction: direction, position: {x, y}}
  end

  def create(_, _), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.graphemes()
    |> Enum.reduce(robot, &action(&1, &2))
  end

  # Matching any errors
  defp action(_, {:error, message}), do: {:error, message}

  defp action("A", robot) do
    {x, y} = position(robot)

    case direction(robot) do
      :north -> %{robot | position: {x, y + 1}}
      :east -> %{robot | position: {x + 1, y}}
      :south -> %{robot | position: {x, y - 1}}
      :west -> %{robot | position: {x - 1, y}}
    end
  end

  defp action("L", robot) do
    case direction(robot) do
      :north -> %{robot | direction: :west}
      :east -> %{robot | direction: :north}
      :south -> %{robot | direction: :east}
      :west -> %{robot | direction: :south}
    end
  end

  defp action("R", robot) do
    case direction(robot) do
      :north -> %{robot | direction: :east}
      :east -> %{robot | direction: :south}
      :south -> %{robot | direction: :west}
      :west -> %{robot | direction: :north}
    end
  end

  defp action(_, _), do: {:error, "invalid instruction"}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
