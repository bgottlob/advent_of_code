true  = Password.valid_1?(111111) 
false = Password.valid_1?(223450)
false = Password.valid_1?(123789)

IO.puts("Part 1 tests passed!")

true  = Password.valid?(112233) 
false = Password.valid?(123444)
true  = Password.valid?(111122)

IO.puts("Part 2 tests passed!")
