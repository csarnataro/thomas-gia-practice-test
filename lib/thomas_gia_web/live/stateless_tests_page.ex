defmodule ThomasGIAWeb.StatelessTestsPage do
  # This is called TestPage not because it's a test as in "unit test" or "whatsoever test"
  # It's actually a page where a user can have their Thomas GIA test

  @deprecated "Use StatefulTestPage instead"

  require Logger
  alias ThomasGIAWeb.Spatial
  alias ThomasGIAWeb.Word
  alias ThomasGia.Tests
  alias ThomasGIAWeb.Perceptual
  alias ThomasGIAWeb.Reasoning
  alias ThomasGIAWeb.Number
  use ThomasGIAWeb, :live_view

  @test_list [
    {:reasoning, 3},
    {:perceptual, 4},
    {:number, 5},
    {:word, 4},
    {:spatial, 3}
  ]

  @impl true
  def mount(_params, _session, socket) do
    current_step = {:reasoning, 0}

    scores = %{
      reasoning: %{ok: 0, ko: 0},
      perceptual: %{ok: 0, ko: 0},
      number: %{ok: 0, ko: 0},
      word: %{ok: 0, ko: 0},
      spatial: %{ok: 0, ko: 0}
    }

    # arithmetic_tests = get_arithmetic_test()
    # cognitive_tests = get_cognitive_test()

    {:ok,
     socket
     |> assign(current_step: current_step)
     |> assign(test_list: @test_list)
     |> assign(scores: scores)}
  end

  @impl true
  def render(assigns) do
    if Map.has_key?(assigns, :halt) do
      ~H"""
      <h1 class="text-2xl">Finito</h1>
      <section>Score here...</section>
      """
    else
      ~H"""
      <%= render_test(assigns, @current_step) %>
      <pre><%= inspect(@current_step) %></pre>
      """
    end
  end

  defp render_test(assigns, {:reasoning, number}) do
    Logger.info("IN render_test(assigns, {:reasoning")

    sentence_read =
      if !Map.has_key?(assigns, :sentence_read), do: false, else: assigns.sentence_read

    number_of_question = number_of_question(:reasoning)

    reasoning_test = Tests.get_test(:reasoning)

    assigns =
      assigns
      |> assign(sentence_read: sentence_read)
      |> assign(number: number)
      |> assign(test: reasoning_test)
      |> assign(total_number_of_question: number_of_question)

    ~H"""
    <.live_component module={Reasoning} id={:reasoning} sentence_read={@sentence_read} test={@test} />
    <%= @number %> / <%= @total_number_of_question %>
    """
  end

  defp render_test(assigns, {:spatial, number}) do
    Logger.info("******** IN RENDER TEST spatial ********")
    total_number_of_question = number_of_question(:spatial)

    assigns = assign(assigns, number: number)
    assigns = assign(assigns, total_number_of_question: total_number_of_question)

    test = Tests.get_test(:perceptual)

    assigns = assign(assigns, test: test)

    ~H"""
    <.live_component module={Spatial} id={:spatial} test={@test} />
    """
  end

  defp render_test(assigns, {:perceptual, number}) do
    Logger.info("******** IN RENDER TEST perceptual ********")
    total_number_of_question = number_of_question(:perceptual)

    assigns = assign(assigns, number: number)
    assigns = assign(assigns, total_number_of_question: total_number_of_question)

    test = Tests.get_test(:perceptual)

    assigns = assign(assigns, test: test)

    ~H"""
    <.live_component module={Perceptual} id={:perceptual} test={@test} />
    """
  end

  defp render_test(assigns, {:word, number}) do
    Logger.info("******** IN RENDER TEST word ********")
    total_number_of_question = number_of_question(:perceptual)

    assigns = assign(assigns, number: number)
    assigns = assign(assigns, total_number_of_question: total_number_of_question)

    test = Tests.get_test(:word)
    assigns = assign(assigns, test: test)

    ~H"""
    <.live_component module={Word} id={:word} test={@test} />
    <%= @number %> / <%= @total_number_of_question %>
    <pre><%= inspect(assigns.current_step) %></pre>
    """
  end

  defp render_test(assigns, {:number, number}) do
    Logger.info("******** IN RENDER TEST number ********")

    total_number_of_question = number_of_question(:number)

    assigns = assign(assigns, number: number)
    assigns = assign(assigns, total_number_of_question: total_number_of_question)

    math_test = Tests.get_test(:number)

    assigns = assign(assigns, test: math_test)

    ~H"""
    <.live_component module={Number} id={:number} test={@test} />
    <%= @number %> / <%= @total_number_of_question %>
    <pre><%= inspect(assigns.current_step) %></pre>
    """
  end

  # @impl true
  # def handle_event("vote_reasoning", params, socket) do
  #   vote = params["vote"]
  #   send(self(), {:vote_reasoning, vote})
  #   {:noreply, socket}
  # end

  def handle_event("reasoning_sentence_read", _params, socket) do
    send(self(), {:reasoning_sentence_read, true})

    {:noreply, socket}
  end

  # @impl true
  # def handle_event("vote_perceptual", params, socket) do
  #   vote = params["vote"]
  #   send(self(), {:vote_perceptual, vote})
  #   {:noreply, socket}
  # end

  # @impl true
  # def handle_event("vote_number", params, socket) do
  #   vote = params["vote"]
  #   send(self(), {:vote_number, vote})
  #   {:noreply, socket}
  # end

  # @impl true
  # def handle_event("vote_word", params, socket) do
  #   vote = params["vote"]
  #   send(self(), {:vote_word, vote})
  #   {:noreply, socket}
  # end

  @impl true
  def handle_event("vote_" <> test, params, socket) do
    vote = params["vote"]
    send(self(), {String.to_atom("vote_" <> test), vote})
    {:noreply, socket}
  end

  @impl true
  def handle_info({:reasoning_sentence_read, sentence_read}, socket) do
    Logger.info("in HANDLE_INFO :reasoning_sentence_read #{inspect(sentence_read)}")
    {:noreply, assign(socket, sentence_read: sentence_read)}
  end

  def handle_info({:vote_reasoning, vote}, %{assigns: %{current_step: current_step}} = socket) do
    Logger.info("in HANDLE_INFO :vote_reasoning #{inspect(vote)}")

    {:continue, next_step} = calculate_next_step(current_step)
    socket = assign(socket, current_step: next_step)

    socket =
      socket
      |> assign(:sentence_read, false)

    {:noreply, socket}
  end

  def handle_info({:vote_perceptual, vote}, %{assigns: %{current_step: current_step}} = socket) do
    Logger.info("in HANDLE_INFO :vote_perceptual #{inspect(vote)}")

    {:continue, next_step} = calculate_next_step(current_step)
    socket = assign(socket, current_step: next_step)

    {:noreply, socket}
  end

  def handle_info({:vote_spatial, vote}, %{assigns: %{current_step: current_step}} = socket) do
    Logger.info("in HANDLE_INFO :vote_spatial #{inspect(vote)}")

    case calculate_next_step(current_step) do
      {:continue, next_step} ->
        socket = assign(socket, current_step: next_step)
        socket = assign(socket, current_step: next_step)
        {:noreply, socket}

      {:halt} ->
        socket = assign(socket, halt: true)
        {:noreply, socket}
    end
  end

  def handle_info({:vote_number, vote}, %{assigns: %{current_step: current_step}} = socket) do
    Logger.info("in HANDLE_INFO :vote_number #{inspect(vote)}")
    {:continue, next_step} = calculate_next_step(current_step)
    socket = assign(socket, current_step: next_step)

    {:noreply, socket}
  end

  def handle_info({:vote_word, vote}, %{assigns: %{current_step: current_step}} = socket) do
    Logger.info("in HANDLE_INFO :vote_word #{inspect(vote)}")
    {:continue, next_step} = calculate_next_step(current_step)
    socket = assign(socket, current_step: next_step)

    {:noreply, socket}
  end

  defp number_of_question(current_test) do
    Enum.find(@test_list, fn test -> elem(test, 0) == current_test end) |> elem(1)
  end

  defp calculate_next_step(current_step) do
    test_type = elem(current_step, 0)
    number = elem(current_step, 1)
    max_number_of_question = number_of_question(test_type)

    if number < max_number_of_question - 1 do
      {:continue, {test_type, number + 1}}
    else
      next_test_index = Enum.find_index(@test_list, fn test -> elem(test, 0) == test_type end)
      next_test = Enum.at(@test_list, next_test_index + 1)

      if next_test do
        {:continue, {elem(next_test, 0), 0}}
      else
        {:halt}
      end
    end
  end
end
