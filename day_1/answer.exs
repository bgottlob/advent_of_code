sum =
  File.stream!("./input")
  |> Stream.map(fn str -> String.trim_trailing(str) |> String.to_integer end)
  |> Enum.reduce(0, fn(mass, acc) -> Fuel.required(mass) + acc end)

IO.puts("The total fuel requirement is #{sum}")
