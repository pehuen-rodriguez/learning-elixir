prefixer = fn prefix ->
  fn thing ->
    "#{prefix} #{thing}"
  end
end

prefixed = prefixer.("Mrs")
IO.puts prefixed.("Gil")

IO.puts prefixer.("Elixir").("Rocks")
