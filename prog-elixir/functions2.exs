fizz_fuzz =
  fn 0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, a -> a
end

IO.puts fizz_fuzz.(0, 0, "cuki")
IO.puts fizz_fuzz.(0, "coco", "cuki")
IO.puts fizz_fuzz.("colo", 0, "cuki")
IO.puts fizz_fuzz.("colo", "poco", "roto")
