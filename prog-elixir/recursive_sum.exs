defmodule RecSum do
  def su(1), do: 1
  def su(n), do: n + su(n-1)
end
