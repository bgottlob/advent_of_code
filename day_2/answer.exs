defmodule Intcode.Run do
  def fix_and_execute(noun, verb) do
    Intcode.read_cpu_state_file("./input")
    |> put_elem(1, noun)
    |> put_elem(2, verb)
    |> Intcode.execute()
  end
end

IO.puts("The intcode output for part 1 is #{Intcode.Run.fix_and_execute(12, 2)}.")

output = 19690720
for noun <- 1..99, verb <- 1..99 do
  if (Intcode.Run.fix_and_execute(noun, verb) == output) do
    IO.puts(
      "Inputs to produce output #{output}:\n\tNoun: #{noun}\n\tVerb #{verb}\n" <>
      "100 * Noun + Verb = #{(100 * noun) + verb}"
    )
    exit(:normal)
  end
end
