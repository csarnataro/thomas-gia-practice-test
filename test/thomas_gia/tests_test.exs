defmodule ThomasGIA.TestsTest do
  alias ThomasGia.Tests
  use ExUnit.Case

  @tag :skip
  describe "perceptual" do
    # tests = Tests.get_test(:perceptual)
    tests =
      Enum.map(0..9, fn _ ->
        tests =
          Tests.build_reasoning_test()
          |> IO.inspect()
      end)

    assert length(tests) == 10
  end

  describe "get_matching_pair" do
    matching_pair = Tests.get_matching_pair()
    assert elem(Enum.at(matching_pair, 0), 0) == elem(Enum.at(matching_pair, 1), 0)
  end

  describe "get_non_matching_pair" do
    matching_pair = Tests.get_non_matching_pair()
    assert elem(Enum.at(matching_pair, 0), 0) != elem(Enum.at(matching_pair, 1), 0)
    assert Enum.at(matching_pair, 0) != Enum.at(matching_pair, 1)
  end
end
