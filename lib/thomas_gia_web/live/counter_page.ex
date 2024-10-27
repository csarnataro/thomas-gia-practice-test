defmodule ThomasGIAWeb.CounterPage do
  alias ThomasGia.CounterState
  use ThomasGIAWeb, :live_view

  def render(assigns) do
    ~H"""
    <pre><%= @session %></pre>
    <div><%= @val %></div>
    <button class="rounded-lg mt-4  bg-blue-600 p-2 text-white" phx-click="inc">Increment</button>
    """
  end

  def handle_event("inc", _params, socket) do
    {:noreply, socket |> assign(val: CounterState.increment())}
    # {:noreply, update(socket, :val, &(&1 + 1))}
  end

  def mount(_params, session, socket) do
    {:ok, assign(socket, %{session: inspect(session), val: CounterState.current()})}
  end
end
