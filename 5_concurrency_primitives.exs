defmodule Concurrency do
  def run_query(query_def) do
    :timer.sleep(10000)
    IO.puts "#{query_def} query"
  end

  def async_query(query_def) do
    spawn(fn -> run_query(query_def) end)
  end

  def start(i) do
    1..i |> Enum.map(&async_query("async #{&1}"))
  end
end

defmodule Messages do
  def ping_process do
    caller = self
    IO.puts "ping listening..."
    receive do
      {:pong, pid} ->
        IO.puts "ping!"
        send(pid, {:ping, caller})
    end
    ping_process
  end

  def pong_process(ping_pid) do
    caller = self
    IO.puts "pong listening..."
    send(ping_pid, {:pong, caller})
    receive do
      {:ping, pid} ->
        IO.puts "pong!"
        send(pid, {:pong, caller})
    end
    pong_process(ping_pid)
  end

  def ping do
    spawn(fn -> ping_process end)
  end

  def pong(ping_pid) do
    spawn(fn -> pong_process(ping_pid) end)
  end

  def loop(a) do
    IO.puts a
    a = a + 1
    loop(a)
  end
end
