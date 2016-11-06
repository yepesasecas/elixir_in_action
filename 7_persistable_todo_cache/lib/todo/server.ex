defmodule Todo.Server do
  use GenServer

  def start(todo_list_name) do
    GenServer.start(Todo.Server, todo_list_name)
  end

  def add_entry(todo_server, new_entry) do
    GenServer.cast(todo_server, {:add_entry, new_entry})
  end

  def entries(todo_server, date) do
    GenServer.call(todo_server, {:entries, date})
  end


  def init(todo_list_name) do
    {:ok, {todo_list_name, Todo.Database.get(todo_list_name) || Todo.List.new}}
  end


  def handle_cast({:add_entry, new_entry}, {todo_list_name, todo_list}) do
    new_state = Todo.List.add_entry(todo_list, new_entry)
    Todo.Database.store(todo_list_name, new_state)
    {:noreply, {todo_list_name, new_state}}
  end


  def handle_call({:entries, date}, _, {todo_list_name,todo_list}) do
    {:reply, Todo.List.entries(todo_list, date), {todo_list_name, todo_list}}
  end

  # Needed for testing purposes
  def handle_info(:stop, todo_list), do: {:stop, :normal, todo_list}
  def handle_info(_, state), do: {:noreply, state}
end
