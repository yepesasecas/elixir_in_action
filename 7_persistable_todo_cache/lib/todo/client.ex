defmodule Todo.Client do
  def start(cache_server, i) do
    list_server = Todo.Cache.server_process(cache_server, "Todo.Client.List#{i}")
    1..1000
      |> Enum.each(fn(j) ->
          :timer.sleep(:rand.uniform(1000))
          Todo.Server.add_entry(list_server, %{date: {2013, 12, 19}, title: "Todo.Client#{i}"})
          IO.puts "Todo.Client#{i} add!"
         end)

    IO.puts "Todo.Client#{i} Done!"
  end
end

# list_server = Todo.Cache.server_process(cache, "Todo.Client.List1")
# Todo.Server.entries list_server, {2013, 12, 19}
