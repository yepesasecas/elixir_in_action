defmodule Todo.Client do
  def start(i) do
    list_server = Todo.Cache.server_process("Todo.Client.List#{i}")
    1..1000
      |> Enum.each(fn(_) ->
          :timer.sleep(:rand.uniform(1000))
          Todo.Server.add_entry(list_server, %{date: {2013, 12, 19}, title: "Todo.Client#{i}"})
         end)

    IO.puts "Todo.Client#{i} Done!"
  end
end
