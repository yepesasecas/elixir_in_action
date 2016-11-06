defmodule Todo.Cache do
  use GenServer

  # Interface functions
  def start_link do
    GenServer.start_link(__MODULE__, nil, name: :cache_server)
  end

  def server_process(todo_list_name) do
    GenServer.call(:cache_server, {:server_process, todo_list_name})
  end


  #Module Callback functions
  def init(_) do
    IO.inspect "init Todo.Cache"
    Todo.Database.start_link("./persist/")
    {:ok, HashDict.new}
  end

  def handle_call({:server_process, todo_list_name}, _, todo_servers) do
    case HashDict.fetch(todo_servers, todo_list_name) do
      {:ok, todo_server} ->
        {:reply, todo_server, todo_servers}
      :error ->
        {:ok, new_server} = Todo.Server.start_link(todo_list_name)
        {:reply, new_server, HashDict.put(todo_servers, todo_list_name, new_server)}
    end
  end
end
