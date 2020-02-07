defmodule Genious do
  # 273, 1..1000
  def guess(chosen, (a..b)) do
    # 500
    middle = div(a+b, 2)
    IO.puts "Have you selected #{middle}? Let's see"
    check chosen, a..b, middle
  end

  def check(chosen, (_a.._b), middle) when middle == chosen do
    IO.puts "YES!"
    chosen
  end
  def check(chosen, (a.._b), middle) when middle > chosen do
    IO.puts "No... let's try again"
    guess chosen, a..middle-1
  end
  def check(chosen, (_a..b), middle) when middle < chosen do
    IO.puts "No... let's try again"
    guess chosen, middle+1..b
  end
end
