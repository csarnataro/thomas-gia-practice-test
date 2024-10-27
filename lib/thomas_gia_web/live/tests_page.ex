defmodule ThomasGIAWeb.TestsPage do
  # This is called TestPage not because it's a test as in "unit test" or "whatsoever test"
  # It's actually a page where a user can have their Thomas GIA test

  require Logger
  alias ThomasGIAWeb.Spatial
  alias ThomasGIAWeb.Word
  alias ThomasGIAWeb.Number
  alias ThomasGIAWeb.Perceptual
  alias ThomasGIAWeb.Reasoning
  alias ThomasGia.TestProgress
  use ThomasGIAWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(progress: TestProgress.current())}
  end

  @impl true
  def render(assigns) do
    %{progress: %{section: section} = progress} = assigns

    assigns =
      assigns
      |> assign(:score, progress[:score][section])
      |> assign(:section, section)
      |> assign(:progress, progress)

    if section == :halt do
      ~H"""
      <h1 class="text-2xl">Finito</h1>
      <section>Final score: <%= inspect(@progress.score) %></section>
      <button class="rounded-lg mt-4  bg-blue-600 p-2 text-white" phx-click="reset">Reset</button>
      """
    else
      ~H"""
      <%= render_test(assigns) %>
      <br />
      <button class="rounded-lg mt-4  bg-blue-600 p-2 text-white" phx-click="reset">Reset</button>
      """
    end
  end

  defp render_test(assigns) do
    Logger.info("IN render_test: #{assigns.section}")
    #
    current_state = TestProgress.current()
    step = current_state.step
    test = current_state.test
    out_of = current_state.out_of

    assigns =
      assigns
      |> assign(test: test)
      |> assign(step: step)
      |> assign(out_of: out_of)
      |> assign(show_question: current_state.show_question)

    if test do
      ~H"""
      <.live_component
        module={get_view(@section)}
        id={@section}
        sentence_read={@show_question}
        test={@test}
      />
      <%= @step + 1 %> / <%= @out_of %>
      """
    else
      ~H"""
      <div>No question found</div>
      """
    end
  end

  @impl true
  def handle_event("vote_" <> _test, params, socket) do
    vote = params["vote"]

    new_state = TestProgress.vote(vote)
    {:noreply, assign(socket, progress: new_state)}
  end

  @impl true
  def handle_event("reasoning_sentence_read", _params, socket) do
    new_state = TestProgress.reveal_question()
    {:noreply, assign(socket, progress: new_state)}
  end

  @impl true
  def handle_event("reset", _params, socket) do
    new_state = TestProgress.reset()
    {:noreply, assign(socket, progress: new_state)}
  end

  defp get_view(:reasoning), do: Reasoning
  defp get_view(:number), do: Number
  defp get_view(:perceptual), do: Perceptual
  defp get_view(:word), do: Word
  defp get_view(:spatial), do: Spatial
end
