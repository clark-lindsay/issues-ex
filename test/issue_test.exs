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
             "created_at" => "2015-01-23T17:00:31Z"
           }) === %Issue{
             id: "test-id",
             url: "test-url",
             state: "test-state",
             username: "test-user",
             title: "test-title",
             body: "test-body",
             created_at: ~U[2015-01-23 17:00:31Z]
           }
  end
end
