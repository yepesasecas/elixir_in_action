defmodule Todo.Database do
  use GenServer

  # Interface Functions
  def start_link(db_folder) do
    GenServer.start_link(__MODULE__, db_folder, name: :database_server)
  end

  def store(key, data) do
    GenServer.cast(:database_server, {:store, key, data})
  end

  def get(key) do
    GenServer.call(:database_server, {:get, key})
  end

  # Module Callback Functions
  def init(db_folder) do
    IO.inspect "init Todo.Database"
    File.mkdir_p(db_folder)
    workers = HashDict.new
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 0, worker)
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 1, worker)
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 2, worker)
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 3, worker)
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 4, worker)
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 5, worker)
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 6, worker)
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 7, worker)
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 8, worker)
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 9, worker)
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 10, worker)
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 11, worker)
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 12, worker)
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 13, worker)
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 14, worker)
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 15, worker)
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 16, worker)
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 17, worker)
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 18, worker)
    {:ok, worker} = Todo.DatabaseWorker.start_link(db_folder)
    workers = HashDict.put(workers, 19, worker)

    {:ok, {db_folder, workers}}
  end

  def handle_cast({:store, key, data}, {db_folder, workers}) do
    {:ok, worker} = HashDict.fetch(workers, get_worker(key))
    Todo.DatabaseWorker.store(worker, key, data)
    {:noreply, {db_folder, workers}}
  end

  def handle_call({:get, key}, _, {db_folder, workers}) do
    {:ok, worker} = HashDict.fetch(workers, get_worker(key))
    data = Todo.DatabaseWorker.get(worker, key)
    {:reply, data, {db_folder, workers}}
  end

  def get_worker(key) do
    :erlang.phash2(key, 20)
  end
end
