defmodule ThomasGIAWeb.Number do
  use ThomasGIAWeb, :live_component

  def show(assigns) do
    ~H"""
    <div>
      <h1 class="section-title">Section 3 - Number Speed and Accuracy</h1>
      <section>
        <ul class="flex justify-center mb-6">
          <li
            :for={n <- @test.options}
            phx-click={:vote_number}
            phx-value-vote={n}
            class="vote_button"
          >
            <span class="text-2xl"><%= n %></span>
          </li>
        </ul>
        <pre><%=@test.answer%></pre>
      </section>
    </div>
    """
  end
end
