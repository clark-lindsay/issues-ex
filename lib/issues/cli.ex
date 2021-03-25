defmodule Issues.CLI do
  @default_count 4

  import Issues.GithubIssues, only: [fetch: 2]
  import Poison, only: [decode!: 1]
  alias Issues.Issue
  import Issue, only: [to_issue: 1]

  def run(argv) do
    argv
    |> parse_args()
    |> process()
    |> decode_response()
    |> sort_by_date_ascending()
  end

  def process({user, project, count}) do
    IO.puts("Fetching #{count} issues...")
    fetch(user, project)
  end

  def process(:help) do
    IO.puts("""
    usage:  issues <user> <project> [ count | #{@default_count} ]
    """)

    System.halt(0)
  end

  def decode_response({:ok, body}) do
    body
    |> decode!
    |> Enum.map(&to_issue(&1))
  end

  def decode_response({:error, error_message}) do
    IO.puts("Error from the github API: #{error_message}")
    System.halt(2)
  end

  def sort_by_date_ascending(issues) do
    issues |> Enum.sort(&(DateTime.compare(&1.created_at, &2.created_at) == :gt))
  end

  def parse_args(argv) do
    OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    |> elem(1)
    |> args_to_internal_representation()
  end

  defp args_to_internal_representation([user, project, count]) do
    {user, project, String.to_integer(count)}
  end

  defp args_to_internal_representation([user, project]), do: {user, project, @default_count}
  defp args_to_internal_representation(_), do: :help
end
