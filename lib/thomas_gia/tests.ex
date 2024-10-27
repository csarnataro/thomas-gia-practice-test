defmodule ThomasGia.Tests do
  require Logger
  alias ThomasGia.CognitiveTestLetters
  alias ThomasGia.Words
  alias ThomasGia.Reasoning

  require Logger

  @picture_angles [{0, 0}, {0, 90}, {0, 180}, {0, 270}, {1, 0}, {1, 90}, {1, 180}, {1, 270}]

  def build_reasoning_test do
    [person_1, person_2] = Enum.take_random(Reasoning.get_people(), 2)
    adjective = Enum.random(Reasoning.get_adjectives())
    adverb = Enum.random(Reasoning.get_adverbs())

    sentence =
      if adverb == "is" do
        "#{person_1} #{adverb} #{adjective[:comparative]} than #{person_2}."
      else
        if adverb == "is not as" do
          "#{person_1} #{adverb} #{adjective[:adjective]} as #{person_2}."
        end
      end

    situation = :rand.uniform(2) - 1

    question =
      if situation == 0 do
        "Who is #{adjective[:antonym]}?"
      else
        if situation == 1 do
          "Who is #{adjective[:comparative]}?"
        end
      end

    answer =
      if adverb == "is" do
        if situation == 0 do
          person_2
        else
          person_1
        end
      else
        if adverb == "is not as" do
          if situation == 0 do
            person_1
          else
            person_2
          end
        end
      end

    reasoning_test = %{
      sentence: sentence,
      question: question,
      options: Enum.shuffle([person_1, person_2]),
      answer: answer
    }

    reasoning_test
  end

  defp build_arithmetic_test do
    lower = :rand.uniform(15)
    higher = lower + 5 + :rand.uniform(10)
    medium = lower + :rand.uniform(higher - lower - 1)

    if medium - lower != higher - medium do
      answer = if medium - lower > higher - medium, do: lower, else: higher

      {first_index, remaining_indexes} = List.pop_at([0, 1, 2], :rand.uniform(3) - 1)
      {second_index, remaining_indexes} = List.pop_at(remaining_indexes, :rand.uniform(2) - 1)
      {third_index, _} = List.pop_at(remaining_indexes, 0)

      numbers =
        []
        |> List.insert_at(first_index, lower)
        |> List.insert_at(second_index, medium)
        |> List.insert_at(third_index, higher)

      %{
        options: numbers,
        # :lower => lower,
        # :medium => medium,
        # :higher => higher,
        answer: Integer.to_string(answer)
      }
    else
      build_arithmetic_test()
    end
  end

  defp build_words_test do
    words = Words.get()

    pair = Enum.random(words)

    other_pairs =
      Enum.filter(words, fn word_set ->
        word_set.type == pair.type && word_set.word_1 != pair.word_1
      end)

    second_pair = Enum.random(other_pairs)

    third_word = Enum.random([second_pair.word_1, second_pair.word_2])

    Logger.debug("OTHER: #{inspect(third_word)}")
    options = Enum.shuffle([pair.word_1, pair.word_2, third_word])

    %{
      options: options,
      answer: third_word
    }
  end

  @doc """
    The algorithm used in this function is inspired by the one used in
    https://github.com/DanielM24/GIA-Practice-Tests
    But instead of using a finely weighted random function, in the present
    implementation we're simply doubling the weight of the random letter,
    so that chances to have a couple with the same letter is slightly higher
    than having different letters.
  """
  def get_letter_pair(random_letter) do
    letters = CognitiveTestLetters.get()

    ## this way, the letter itself has double the chance to be chosen
    all_letters = [random_letter | [random_letter | letters[random_letter]]]
    second_letter = all_letters |> Enum.at(:rand.uniform(length(all_letters)) - 1)

    [random_letter, second_letter]
  end

  defp append_letter(set) do
    letters = CognitiveTestLetters.get()
    letters_keys = Map.keys(letters)

    random_letter = Enum.random(letters_keys)

    set = MapSet.put(set, random_letter)

    if MapSet.size(set) == 4 do
      set
    else
      append_letter(set)
    end
  end

  def build_cognitive_test do
    letter_set = append_letter(MapSet.new())

    test =
      Enum.map(letter_set, &get_letter_pair/1)
      |> Enum.reduce(%{rows: [[], []], answer: 0}, fn pair, acc ->
        answer = if Enum.at(pair, 0) == Enum.at(pair, 1), do: acc.answer + 1, else: acc.answer

        %{
          rows: [
            [Enum.at(pair, 0) | Enum.at(acc.rows, 0)],
            [Enum.at(pair, 1) | Enum.at(acc.rows, 1)]
          ],
          answer: answer
        }
      end)

    capitalized_rows =
      if :rand.uniform() <= 0.5 do
        [
          Enum.at(test.rows, 0),
          Enum.at(test.rows, 1) |> Enum.map(&String.upcase/1)
        ]
      else
        [
          Enum.at(test.rows, 0) |> Enum.map(&String.upcase/1),
          Enum.at(test.rows, 1)
        ]
      end

    %{
      question: %{
        upper_row: Enum.at(capitalized_rows, 0),
        lower_row: Enum.at(capitalized_rows, 1)
      },
      answer: Integer.to_string(test.answer)
    }
  end

  def build_spatial_test do
    chars = ["R", "N", "S", "F", "P", "G"]

    random_chars = Enum.take_random(chars, 2)
    answer = :rand.uniform(3) - 1

    pairs =
      case :rand.uniform(3) - 1 do
        1 ->
          [
            get_matching_pair(),
            get_non_matching_pair()
          ]

        _ ->
          [
            get_matching_pair(),
            get_matching_pair()
          ]
      end

    %{
      pairs: pairs,
      chars: random_chars,
      answer: Integer.to_string(answer)
    }
  end

  def get_non_matching_pair() do
    pair = Enum.take_random(@picture_angles, 2)

    if elem(Enum.at(pair, 0), 0) != elem(Enum.at(pair, 1), 0) do
      pair
    else
      get_non_matching_pair()
    end
  end

  def get_matching_pair() do
    pair = Enum.take_random(@picture_angles, 2)

    if elem(Enum.at(pair, 0), 0) == elem(Enum.at(pair, 1), 0) &&
         Enum.at(pair, 0) != Enum.at(pair, 1) do
      pair
    else
      get_matching_pair()
    end
  end

  # def get_non_matching_r(self):
  #       while True:
  #           pair = sample(self.picture_angles, 2)
  #           if pair[0][0] != pair[1][0]:
  #               return pair

  #   def get_matching_r(self):
  #       while True:
  #           pair = sample(self.picture_angles, 2)
  #           if pair[0][0] == pair[1][0] and pair[0] != pair[1]:
  #               return pair

  def get_test(other) do
    raise("No test found [#{other}] !")
  end

  def get_tests(:reasoning, how_many) do
    Enum.map(1..how_many, fn _i -> build_reasoning_test() end)
  end

  def get_tests(:number, how_many) do
    Enum.map(1..how_many, fn _i -> build_arithmetic_test() end)
  end

  def get_tests(:perceptual, how_many) do
    Enum.map(1..how_many, fn _i -> build_cognitive_test() end)
  end

  def get_tests(:word, how_many) do
    Enum.map(1..how_many, fn _i -> build_words_test() end)
  end

  def get_tests(:spatial, how_many) do
    Enum.map(1..how_many, fn _i -> build_spatial_test() end)
  end
end
