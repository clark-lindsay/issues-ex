defmodule Issues.Parse do
  def decode(json_string) do
    Poison.decode(json_string)
  end
end
