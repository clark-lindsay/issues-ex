defmodule CLITest do
  use ExUnit.Case 

  doctest Issues

  import Issues.CLI, only: [parse_args: 1]

  test ":help returned by passing either -h or --help" do
    assert parse_args(["-h", "anything_at_all"]) == :help
    assert parse_args(["--help", "anything_at_all"]) == :help
  end

  test "3 values returned if 3 are given" do
    assert parse_args(["user", "project", "99"]) == { "user", "project", 99 }
  end

  test "uses a default count if one is not given" do
    assert parse_args(["user", "project"]) == { "user", "project", 4 }
  end
end
