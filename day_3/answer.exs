[wire_1, wire_2] =
  Wires.Input.file_to_move_str_lists("input")
  |> Stream.map(fn move_str_list ->
       Enum.map(move_str_list, fn str -> Wires.Input.to_move(str) end)
      end)
  |> Enum.map(&(Wires.track_wire(&1)))

intersections = Wires.intersections(wire_1, wire_2)

answer_1 =
  intersections
  |> Stream.map(&(Manhattan.distance(&1)))
  |> Enum.min()

IO.puts("Part 1 answer: #{answer_1}")

answer_2 = 
  intersections
  |> Stream.map(&(Map.get(&1, :steps)))
  |> Enum.min()

IO.puts("Part 2 answer: #{answer_2}")
