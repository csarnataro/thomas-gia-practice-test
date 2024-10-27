defmodule ThomasGIAWeb.Spatial do
  use ThomasGIAWeb, :live_component

  # %{
  #   pairs: pairs,
  #   chars: random_chars,
  #   answer: Integer.to_string(answer)
  # }

  defp get_rotation(pairs, x, y) do
    pairs |> Enum.at(x) |> Enum.at(y) |> elem(1)
  end

  defp get_orientation(pairs, x, y) do
    pairs |> Enum.at(x) |> Enum.at(y) |> elem(0)
  end

  defp get_style(pairs, x, y) do
    rotation = pairs |> get_rotation(x, y)
    orientation = pairs |> get_orientation(x, y)
    "transform: rotate(#{rotation}deg) #{if orientation != 0, do: "scale(-1, 1)"}"
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1 class="section-title">Section 5 - Spacial Visualisation</h1>
      <section class="flex">
        <article class="flex flex-col items-center m-auto mr-4 px-8 py-4 bg-white ">
          <div class="mb-4 flex flex-col p-2 text-7xl text-grey-800">
            <span style={@test.pairs |> get_style(0, 0)}>
              <%= Enum.at(@test.chars, 0) %>
            </span>
            <span style={@test.pairs |> get_style(0, 1)}>
              <%= Enum.at(@test.chars, 0) %>
            </span>
          </div>
        </article>
        <article class="flex flex-col items-center m-auto ml-4 px-8 py-4 bg-white">
          <div class="mb-4 flex flex-col p-2 text-7xl text-neutral-800">
            <span style={@test.pairs |> get_style(1, 0)}>
              <%= Enum.at(@test.chars, 1) %>
            </span>
            <span style={@test.pairs |> get_style(1, 1)}>
              <%= Enum.at(@test.chars, 1) %>
            </span>
          </div>
        </article>
      </section>
      <article>
        <%= inspect(@test.pairs |> Enum.at(0) |> Enum.at(0) |> elem(0)) %> - <%= inspect(
          @test.pairs
          |> Enum.at(0)
          |> Enum.at(0)
          |> elem(1)
        ) %>
      </article>
      <ul class="flex justify-center mb-6">
        <li :for={n <- 0..2} phx-click={:vote_spatial} phx-value-vote={n} class="vote_button">
          <span class="text-2xl"><%= n %></span>
        </li>
      </ul>

      <pre><%= @test.answer %></pre>
    </div>
    """
  end
end
