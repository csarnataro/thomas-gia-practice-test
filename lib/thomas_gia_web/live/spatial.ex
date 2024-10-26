defmodule ThomasGIAWeb.Spatial do
  use ThomasGIAWeb, :live_component

  def show(assigns) do
    ~H"""
    <div>
      <h1 class="section-title">Section 5 - Spacial Visualisation</h1>
      <section>
        <article class="mb-4 flex justify-center">
          <span
            :for={letter <- @test.question.upper_row}
            class="mr-3 block w-12 text-4xl font-bold text-neutral-800 dark:text-neutral-200"
          >
            <%= letter %>
          </span>
        </article>
        <article class="mb-4 flex justify-center">
          <span
            :for={letter <- @test.question.lower_row}
            class="mr-3 block w-12 text-4xl font-bold text-neutral-800 dark:text-neutral-200"
          >
            <%= letter %>
          </span>
        </article>
        <ul class="flex justify-center mb-6">
          <li :for={n <- 0..4} phx-click={:vote_spatial} phx-value-vote={n} class="vote_button">
            <span class="text-2xl"><%= n %></span>
          </li>
        </ul>
      </section>
      <pre><%= @test.answer %></pre>
    </div>
    """
  end
end
