defmodule Todo.DatabaseWorker do
  use GenServer

  # Interface Functions
  def start_link(db_folder) do
    GenServer.start_link(__MODULE__, db_folder)
  end

  def store(worker, key, data) do
    GenServer.cast(worker, {:store, key, data})
  end

  def get(worker, key) do
    GenServer.call(worker, {:get, key})
  end

  # Module Callback Functions
  def init(db_folder) do
    IO.inspect "init Todo.DatabaseWorker"
    File.mkdir_p(db_folder)
    {:ok, db_folder}
  end

  def handle_cast({:store, key, data}, db_folder) do
    file_name(db_folder, key)
      |> File.write!(:erlang.term_to_binary(data))
    {:noreply, db_folder}
  end

  def handle_call({:get, key}, _, db_folder) do
    data = case File.read(file_name(db_folder, key)) do
      {:ok, contents} -> :erlang.binary_to_term(contents)
      _ -> nil
    end

    {:reply, data, db_folder}
  end

  defp file_name(db_folder, key) do
    "#{db_folder}/#{key}"
  end
end
