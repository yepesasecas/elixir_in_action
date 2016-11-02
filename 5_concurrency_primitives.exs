run_query = fn(query_def) ->
  :timer.sleep(2000)
  IO.puts "#{query_def} running"
  "#{query_def} result. "
end

1..5
  |> Enum.map(&run_query.("query #{&1}"))
  |> IO.puts
