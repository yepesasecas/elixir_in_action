defmodule Concurrency do
  def run_query(query_def) do
    :timer.sleep(2000)
    IO.puts "#{query_def} query"
  end

  def async_query(query_def) do
    spawn(fn -> run_query(query_def) end)
  end

  def start(i) do
    1..i |> Enum.map(&async_query("async #{&1}"))
  end
end
