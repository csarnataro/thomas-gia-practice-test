defmodule ThomasGIA.TestsTest do
  alias ThomasGia.Tests
  use ExUnit.Case

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
end
