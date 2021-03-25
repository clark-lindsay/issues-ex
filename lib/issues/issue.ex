defmodule Issues.Issue do
  defstruct [:id, :url, :state, :username, :title, :body, :created_at]

  def to_issue(%{
        "id" => id,
        "url" => url,
        "state" => state,
        "user" => user,
        "title" => title,
        "body" => body,
        "created_at" => created_at
      }) do
    %{"login" => username} = user

    {:ok, date, _utc_offset} = DateTime.from_iso8601(created_at)

    %Issues.Issue{
      id: id,
      url: url,
      state: state,
      username: username,
      title: title,
      body: body,
      created_at: date
    }
  end
end
