defmodule ThomasGIAWeb.Reasoning do
  use ThomasGIAWeb, :live_component

  def show(assigns) do
    ~H"""
    <div>
      <h1 class="section-title">Section 1 - Reasoning</h1>
      <section>
        <p
          class="cursor-pointer m-4 p-8 bg-white text-center rounded select-none"
          phx-click={if @sentence_read, do: "", else: :reasoning_sentence_read}
        >
          <%= if !@sentence_read, do: @test.sentence, else: @test.question %>
        </p>
        <!-- <p><%= @test.question %></p> -->
        <ul class="flex justify-center mb-6">
          <li
            :for={n <- @test.options}
            phx-click={if @sentence_read, do: :vote_reasoning, else: ""}
            phx-value-vote={n}
            class="vote_button"
          >
            <span class="text-2xl">
              <%= if !@sentence_read, do: raw("&nbsp;"), else: n %>
            </span>
          </li>
        </ul>
      </section>
    </div>
    """
  end
end
