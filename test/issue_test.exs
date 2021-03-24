defmodule IssueTest do
  use ExUnit.Case

  alias Issues.Issue
  import Issue, only: [to_issue: 1]

  test "to_issue can convert a map with all relevant keys as strings" do
    assert to_issue(%{
             "id" => "test-id",
             "url" => "test-url",
             "state" => "test-state",
             "user" => %{"login" => "test-user"},
             "title" => "test-title",
             "body" => "test-body",
             "created_at" => "2015-01-23"
           }) === %Issue{
             id: "test-id",
             url: "test-url",
             state: "test-state",
             username: "test-user",
             title: "test-title",
             body: "test-body",
             created_at: ~D[2015-01-23]
           }
  end
end
