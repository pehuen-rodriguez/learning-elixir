defmodule Ticker do

  @interval 2000 # 2 seconds
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[], 0])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def generator(clients, idx) when length(clients) != 0 and idx >= length(clients), do: generator(clients, 0)

  def generator(clients, idx) do
    receive do
      { :register, pid } ->
        IO.puts "registering #{inspect pid}"
        generator([pid | clients], idx) # new list by prepending pid to clients

      after
        @interval ->
          case Enum.at(clients, idx, :none) do
            :none -> IO.puts "[server] I'd be ticking but no one is there to listen"
            client ->
              IO.puts " [server] ticks"
              send client, { :tick }
          end
          generator(clients, idx + 1)
    end
  end

end

defmodule Client do

  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      { :tick } ->
        IO.puts "tock [client]"
        receiver()
    end
  end

end
