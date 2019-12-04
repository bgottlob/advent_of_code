defmodule Fuel do
  def required(mass), do: required(mass, 0)

  defp required(mass, acc) do
    case div(mass, 3) - 2 do
      x when x <= 0 -> acc
      x             -> required(x,  x + acc)
    end
  end
end
