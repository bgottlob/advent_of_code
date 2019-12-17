defmodule Orbit do
  def file_to_orbit_map(filename) do
    File.stream!(filename)
    |> Stream.map(&(String.trim_trailing(&1)))
    |> Stream.map(&(String.split(&1, ")")))
    # key orbits value
    |> Enum.reduce(%{}, fn [com, sat], map -> Map.put(map, sat, com) end)
  end

  # Count direct and indirect orbits
  def count(map) do
    Enum.reduce(map, 0, fn {sat, _com}, acc ->
      acc + count_for_satellite(map, Map.get(map, sat), 0)
    end)
  end

  def count_for_satellite(_map, nil, acc), do: acc
  def count_for_satellite(map, sat, acc) do
    next = Map.get(map, sat)
    count_for_satellite(map, next, acc + 1)
  end

  # Return a list of the ancestors of a given satellite - the list of what
  # that satellite orbits followed by what that orbits ... and so on until COM
  def ancestors_of_satellite(map, sat), do: ancestors_of_satellite(map, sat, [])

  # tl(acc) removes a trailing nil
  defp ancestors_of_satellite(_map, nil, acc), do: Enum.reverse(tl(acc))
  defp ancestors_of_satellite(map, sat, acc) do
    next = Map.get(map, sat)
    ancestors_of_satellite(map, next, [next | acc])
  end

  def first_common_ancestor(l1, l2) when is_list(l2) do
    # Check if an element from list 1 is in list 2. Simplify lookups by running
    # member? with a MapSet representation of list 2.
    first_common_ancestor(l1, MapSet.new(l2))
  end

  def first_common_ancestor([], _), do: {:error, "Common ancestor not found"}
  def first_common_ancestor([x | rest], s2) do
    case MapSet.member?(s2, x) do
      true -> x
      false -> first_common_ancestor(rest, s2)
    end
  end
end
