defmodule Wires.Move do
  defstruct direction: nil, length: 0
end

# Used to represent position while tracking each wires' segments
defmodule Wires.Position do
  defstruct x: 0, y: 0, steps: 0
end

defmodule Wires.VerticalSegment do
  defstruct start: 0, stop: 0, x: 0, steps: 0, forward: true
end

defmodule Wires.HorizontalSegment do
  defstruct start: 0, stop: 0, y: 0, steps: 0, forward: true
end

defmodule Wires.Input do
  alias Wires.Move

  # Transform file input to 
  # Example:
  #   R8,U5,L5,D3
  #   U7,R6,D4,L4
  #   becomes
  #   [ [ "R8", "U5", "L5", "D3" ],
  #     [ "U7", "R6", "D4", "L4" ] ]
  def file_to_move_str_lists(filename) do
    File.stream!(filename)
    |> Stream.map(&(String.split(&1, ",")))
  end

  def to_move(str) do
    [_, dir_str, len_str] = Regex.run(~r/^(U|D|L|R)(\d+)$/, str)
    %Move{direction: to_direction(dir_str), length: String.to_integer(len_str)}
  end

  defp to_direction("U"), do: :up
  defp to_direction("D"), do: :down
  defp to_direction("L"), do: :left
  defp to_direction("R"), do: :right
end

defmodule Wires do
  alias Wires.{Move, Position, HorizontalSegment, VerticalSegment}
  # directions - list formatted like [ "R8", "U5", "L5", "D3" ]
  # Returns list of horizontal segments and vertical segments: {horiz, vert}
  # Each horizontal line segment formatted {start_x, end_y}
  # Each vertical line segment formatted {start_y, end_y}
  def track_wire(moves) do
    track_wire(moves, %Position{x: 0, y: 0, steps: 0}, [])
  end

  defp track_wire([], _coord, acc), do: acc

  defp track_wire([move | rest], pos, acc) do
    {segment, new_pos} = make_move(move, pos)
    track_wire(rest, new_pos, [segment | acc])
  end

  # Steps is the number of steps it takes to reach the end x or y value
  defp make_move(move = %Move{direction: :up}, pos) do
    {
      %VerticalSegment{
        forward: true,
        start: pos.y, stop: pos.y + move.length,
        x: pos.x,
        steps: pos.steps + move.length
      },
      %Position{
        x: pos.x,
        y: pos.y + move.length,
        steps: pos.steps + move.length
      }
    }
  end

  defp make_move(move = %Move{direction: :down}, pos) do
    {
      %VerticalSegment{
        forward: false,
        start: pos.y - move.length, stop: pos.y,
        x: pos.x,
        steps: pos.steps + move.length
      },
      %Position{
        x: pos.x,
        y: pos.y - move.length,
        steps: pos.steps + move.length
      }
    }
  end

  defp make_move(move = %Move{direction: :left}, pos) do
    {
      %HorizontalSegment{
        forward: false,
        start: pos.x - move.length, stop: pos.x,
        y: pos.y,
        steps: pos.steps + move.length
      },
      %Position{
        x: pos.x - move.length,
        y: pos.y,
        steps: pos.steps + move.length
      }
    }
  end

  defp make_move(move = %Move{direction: :right}, pos) do
    {
      %HorizontalSegment{
        forward: true,
        start: pos.x, stop: pos.x + move.length,
        y: pos.y,
        steps: pos.steps + move.length
      },
      %Position{
        x: pos.x + move.length,
        y: pos.y,
        steps: pos.steps + move.length
      }
    }
  end

  # Gets a list of coordinates where the two wires of line segments intersect
  def intersections(wire_1, wire_2) do
    intersections = for seg_1 <- wire_1, seg_2 <- wire_2 do
      intersection(seg_1, seg_2)
    end

    Enum.filter(
      intersections,
      fn %Position{x: 0, y: 0} -> false # Remove origin intersections
         %Position{}           -> true  # Keep "real" intersection positions
         nil                   -> false # Remove nil entries
      end
    )
  end

  defp intersection(h = %HorizontalSegment{}, v = %VerticalSegment{}) do
    if (h.start <= v.x && v.x <= h.stop && v.start <= h.y && h.y <= v.stop) do
      h_walkback = abs(case h.forward do
        true  -> h.stop - v.x
        false -> v.x - h.start
      end)

      v_walkback = abs(case v.forward do
        true -> v.stop - h.y
        false -> h.y - v.start
      end)

      steps = h.steps + v.steps - v_walkback - h_walkback
      %Position{x: v.x, y: h.y, steps: steps}
    else
      nil
    end
  end

  defp intersection(v = %VerticalSegment{}, h = %HorizontalSegment{}) do
    intersection(h, v)
  end

  defp intersection(_,_), do: nil
end

defmodule Manhattan do
  def distance(%Wires.Position{x: x, y: y}), do: abs(x) + abs(y)   
end
