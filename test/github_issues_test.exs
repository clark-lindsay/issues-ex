defmodule GithubTest do
  use ExUnit.Case

  import Issues.GithubIssues, only: [issues_url: 2]

  test "issues_url correctly interpolates the right endpoint" do
    assert issues_url("user", "project") == "https://api.github.com/repos/user/project/issues"
  end
end
