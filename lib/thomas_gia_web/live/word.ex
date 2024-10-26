defmodule ThomasGIAWeb.Word do
  use ThomasGIAWeb, :live_component

  def show(assigns) do
    ~H"""
    <div>
      <h1 class="section-title">Section 4 - Word Meaning</h1>

      <section>
        <ul class="flex justify-center mb-6">
          <li :for={n <- @test.options} phx-click={:vote_word} phx-value-vote={n} class="vote_button">
            <span class="text-2xl"><%= n %></span>
          </li>
        </ul>
        <pre><%=@test.answer%></pre>
      </section>
    </div>
    """
  end
end
