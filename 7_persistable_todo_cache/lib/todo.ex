defmodule Todo do
  def start do
    {:ok, cache} = Todo.Cache.start
    1..1000
      |> Enum.each(fn(i)-> spawn(fn-> Todo.Client.start(cache, i) end) end)
  end
end
