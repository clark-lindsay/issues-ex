defmodule Issues.CLI do
  @default_count 4

  import Issues.GithubIssues, only: [ fetch: 2 ]

  def run(argv) do
    argv
    |> parse_args()
    |> process()
    |> decode_response()
  end

  def process({ user, project, count }) do
    IO.puts "Looking for only #{count} issues..."
    fetch(user, project)
  end
  def process(:help) do
    IO.puts """
    usage:  issues <user> <project> [ count | #{@default_count} ]
    """
    System.halt(0)
  end

  def decode_response({ :ok, body }), do: body
  def decode_response({ :error, error_message }) do
    IO.puts "Error from the github API: #{error_message}"
    System.halt(2)
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
