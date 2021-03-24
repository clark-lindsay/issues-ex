defmodule CLITest do
  use ExUnit.Case

  doctest Issues

  import Issues.CLI, only: [parse_args: 1, sort_by_date_ascending: 1]

  test ":help returned by passing either -h or --help" do
    assert parse_args(["-h", "anything_at_all"]) == :help
    assert parse_args(["--help", "anything_at_all"]) == :help
  end

  test "parse returns 3 values if 3 are given" do
    assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
  end

  test "parse uses a default count if one is not given" do
    assert parse_args(["user", "project"]) == {"user", "project", 4}
  end

  test "sort_by_date_ascending does exactly that" do
    issue_one = %{created_at: ~D[1996-04-23]}
    issue_two = %{created_at: ~D[1996-08-14]}
    issue_three = %{created_at: ~D[1996-08-14]}

    assert sort_by_date_ascending([issue_one, issue_two, issue_three]) == [
             issue_two,
             issue_three,
             issue_one
           ]
  end
end
