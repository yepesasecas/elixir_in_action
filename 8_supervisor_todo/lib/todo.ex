defmodule Todo do
  def start do
    {:ok, _} = Todo.Supervisor.start_link
    1..1000
      |> Enum.each(fn(i)-> spawn(fn-> Todo.Client.start(i) end) end)
  end
end
