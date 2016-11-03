defmodule KeyValueStore do
  use GenServer

  #interface methods
  def start_link(args) do
    GenServer.start_link __MODULE__, args
  end

  def put(pid, key, value) do
    GenServer.cast pid, {:put, key, value}
  end

  def get(pid, key) do
    GenServer.call pid, {:get, key}
  end

  #module Callback methods
  def init(_) do
    {:ok, HashDict.new}
  end

  def handle_call({:get, key}, _, state) do
    {:reply, HashDict.get(state, key), state}
  end

  def handle_cast({:put, key, value}, state) do
    {:noreply, HashDict.put(state, key, value)}
  end
end
