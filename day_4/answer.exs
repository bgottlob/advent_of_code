answer_1 =
  134792..675810
  |> Enum.filter(&(Password.valid_1?(&1)))
  |> length()

IO.puts("Part 1 answer: #{answer_1}")

answer_2 =
  134792..675810
  |> Enum.filter(&(Password.valid?(&1)))
  |> length()

IO.puts("Part 2 answer: #{answer_2}")
