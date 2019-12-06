defmodule Intcode do
  use Agent

  def read_cpu_state_file(input_file) do
    File.read!(input_file)
    |> String.trim_trailing()
    |> String.split(",")
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> List.to_tuple()
  end

  def execute(cpu_state) do
    execute(cpu_state, 0)
  end

  defp execute(cpu_state, position) do
    case elem(cpu_state, position) do
      1  -> execute(add(cpu_state, position), position + 4)
      2  -> execute(multiply(cpu_state, position), position + 4)
      99 -> elem(cpu_state, 0)
    end
  end

  defp add(cpu_state, position) do
    put_elem(
      cpu_state,
      elem(cpu_state, position + 3),
      Enum.reduce(operands(cpu_state, position), 0, &(&1 + &2))
    )
  end

  defp multiply(cpu_state, position) do
    put_elem(
      cpu_state,
      elem(cpu_state, position + 3),
      Enum.reduce(operands(cpu_state, position), 1, &(&1 * &2))
    )
  end

  defp operands(cpu_state, position) do
    [ elem(cpu_state, elem(cpu_state, position + 1)),
      elem(cpu_state, elem(cpu_state, position + 2)) ]
  end
end
