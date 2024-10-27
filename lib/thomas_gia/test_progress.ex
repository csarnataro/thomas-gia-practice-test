defmodule ThomasGia.TestProgress do
  alias ThomasGia.Tests
  use GenServer

  @name :test_progress_server
  @test_list [
    reasoning: 3,
    perceptual: 4,
    number: 5,
    word: 4,
    spatial: 5,
    halt: 0
  ]

  @all_tests [
    reasoning: Tests.get_tests(:reasoning, @test_list[:reasoning]),
    number: Tests.get_tests(:number, @test_list[:number]),
    perceptual: Tests.get_tests(:perceptual, @test_list[:perceptual]),
    word: Tests.get_tests(:word, @test_list[:word]),
    spatial: Tests.get_tests(:spatial, @test_list[:spatial]),
    # conventional halting section
    halt: %{}
  ]

  @start_value %{
    section: :reasoning,
    step: 0,
    out_of: @test_list[:reasoning],
    test: Enum.at(@all_tests[:reasoning], 0),
    show_question: false,
    score: %{
      reasoning: %{ok: 0, ko: 0},
      perceptual: %{ok: 0, ko: 0},
      number: %{ok: 0, ko: 0},
      word: %{ok: 0, ko: 0},
      spatial: %{ok: 0, ko: 0}
    }
    # tests: %{
    #   number: Tests.get_tests(:number, @test_list[:number]),
    #   reasoning: Tests.get_tests(:reasoning, @test_list[:reasoning])
    # }
  }

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, @start_value, name: @name)
  end

  def init(initial_state) do
    {:ok, initial_state}
  end

  # External API (runs in client process)
  def current do
    GenServer.call(@name, :current_progress)
  end

  def reveal_question do
    GenServer.call(@name, :reveal_question)
  end

  def reset do
    GenServer.call(@name, :reset)
  end

  def vote(vote) do
    GenServer.call(@name, {:vote, vote})
  end

  # Implementation (Runs in GenServer process)
  def handle_call(:current_progress, _from, progress) do
    {:reply, progress, progress}
  end

  def handle_call(:reset, _from, _progress) do
    {:reply, @start_value, @start_value}
  end

  def handle_call({:vote, vote}, _from, progress) do
    section = progress.section
    step = progress.step

    new_score =
      if vote == progress.test.answer do
        current_score = %{
          ok: progress.score[section][:ok] + 1,
          ko: progress.score[section][:ko]
        }

        %{progress.score | section => current_score}
      else
        current_score = %{
          ko: progress.score[section][:ko] + 1,
          ok: progress.score[section][:ok]
        }

        %{progress.score | section => current_score}
      end

    # check if we need to switch to a new section

    {next_step, section} =
      if step == @test_list[section] - 1 do
        next_section =
          @test_list
          |> Enum.find_index(fn t -> elem(t, 0) == section end)
          |> then(fn idx -> Enum.at(@test_list, idx + 1) end)
          |> elem(0)

        {0, next_section}
      else
        {progress.step + 1, section}
      end

    test = Enum.at(@all_tests[section], next_step)

    progress = %{
      progress
      | section: section,
        step: next_step,
        out_of: @test_list[section],
        score: new_score,
        show_question: false,
        test: test
    }

    {:reply, progress, progress}
  end

  def handle_call(:reveal_question, _from, progress) do
    new_progress = %{progress | show_question: true}
    {:reply, new_progress, new_progress}
  end
end
