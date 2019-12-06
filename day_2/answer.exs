result =
  Intcode.read_cpu_state_file("./input")
  |> put_elem(1, 12)
  |> put_elem(2, 2)
  |> Intcode.execute()

IO.puts("The intcode output for part 1 is #{result}.")
