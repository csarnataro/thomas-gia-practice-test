defmodule ThomasGia.CounterState do
  use GenServer

  @name :count_server
  @start_value 0

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, @start_value, name: @name)
  end

  def init(initial_count) do
    {:ok, initial_count}
  end

  # External API (runs in client process)
  def increment do
    GenServer.call(@name, :increment_counter)
  end

  def current do
    GenServer.call(@name, :current_value)
  end

  # Implementation (Runs in GenServer process)
  def handle_call(:increment_counter, _from, count) do
    new_count = count + 1
    {:reply, new_count, new_count}
  end

  def handle_call(:decrement_counter, _from, count) do
    new_count = count - 1
    {:reply, new_count, new_count}
  end

  def handle_call(:current_value, _from, count) do
    {:reply, count, count}
  end
end
