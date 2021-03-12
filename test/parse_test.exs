defmodule ParseTest do
  use ExUnit.Case

  import Issues.Parse, only: [decode: 1]

  test "can decode JSON strings" do
    assert decode("[1, 2, 3]") === { :ok, [1, 2, 3] }
  end

  test "fails to decode badly formatted json" do
    assert { :error, _ } = decode("[ 1, 2, 3 }")
  end
end
