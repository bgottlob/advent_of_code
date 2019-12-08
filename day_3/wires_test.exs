[wire_1, wire_2] =
  [ ~w[R8 U5 L5 D3],
    ~w[U7 R6 D4 L4] ]
    |> Stream.map(fn l -> Enum.map(l, fn str -> Wires.Input.to_move(str) end) end)
    |> Enum.map(&(Wires.track_wire(&1)))
6 =
  Wires.intersections(wire_1, wire_2)
  |> Stream.map(&(Manhattan.distance(&1)))
  |> Enum.min()

[wire_1, wire_2] =
  [ ~w[R75 D30 R83 U83 L12 D49 R71 U7 L72],
    ~w[U62 R66 U55 R34 D71 R55 D58 R83] ]
    |> Stream.map(fn l -> Enum.map(l, fn str -> Wires.Input.to_move(str) end) end)
    |> Enum.map(&(Wires.track_wire(&1)))
159 =
  Wires.intersections(wire_1, wire_2)
  |> Stream.map(&(Manhattan.distance(&1)))
  |> Enum.min()

[wire_1, wire_2] =
  [ ~w[R98 U47 R26 D63 R33 U87 L62 D20 R33 U53 R51],
    ~w[U98 R91 D20 R16 D67 R40 U7 R15 U6 R7] ]
    |> Stream.map(fn l -> Enum.map(l, fn str -> Wires.Input.to_move(str) end) end)
    |> Enum.map(&(Wires.track_wire(&1)))
135 =
  Wires.intersections(wire_1, wire_2)
  |> Stream.map(&(Manhattan.distance(&1)))
  |> Enum.min()

IO.puts("Part 1 tests passed!")

[wire_1, wire_2] =
  [ ~w[R8 U5 L5 D3],
    ~w[U7 R6 D4 L4] ]
    |> Stream.map(fn l -> Enum.map(l, fn str -> Wires.Input.to_move(str) end) end)
    |> Enum.map(&(Wires.track_wire(&1)))
30 =
  Wires.intersections(wire_1, wire_2)
  |> Stream.map(&(Map.get(&1, :steps)))
  |> Enum.min()

[wire_1, wire_2] =
  [ ~w[R75 D30 R83 U83 L12 D49 R71 U7 L72],
    ~w[U62 R66 U55 R34 D71 R55 D58 R83] ]
    |> Stream.map(fn l -> Enum.map(l, fn str -> Wires.Input.to_move(str) end) end)
    |> Enum.map(&(Wires.track_wire(&1)))
610 =
  Wires.intersections(wire_1, wire_2)
  |> Stream.map(&(Map.get(&1, :steps)))
  |> Enum.min()

[wire_1, wire_2] =
  [ ~w[R98 U47 R26 D63 R33 U87 L62 D20 R33 U53 R51],
    ~w[U98 R91 D20 R16 D67 R40 U7 R15 U6 R7] ]
    |> Stream.map(fn l -> Enum.map(l, fn str -> Wires.Input.to_move(str) end) end)
    |> Enum.map(&(Wires.track_wire(&1)))
410 =
  Wires.intersections(wire_1, wire_2)
  |> Stream.map(&(Map.get(&1, :steps)))
  |> Enum.min()

IO.puts("Part 2 tests passed!")
