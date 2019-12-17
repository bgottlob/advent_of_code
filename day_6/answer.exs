map = Orbit.file_to_orbit_map("input")
answer_1 = Orbit.count(map)

IO.puts("The answer for part 1 is #{answer_1}")

you_anc = Orbit.ancestors_of_satellite(map, "YOU")
san_anc = Orbit.ancestors_of_satellite(map, "SAN")
anc = Orbit.first_common_ancestor(you_anc, san_anc)

ffn = fn x -> x == anc end
answer_2 = Enum.find_index(you_anc, ffn) + Enum.find_index(san_anc, ffn)

IO.puts("The answer for part 2 is #{answer_2}")
