defmodule PhoenixGraphql.UserAgent do
  alias PhoenixGraphql.GraphQL.UserDto

  @users ~s([
    {"id":"1", "name":"name 1", "email":"1@mail.com"},
    {"id":"2", "name":"name 2", "email":"2@mail.com"},
    {"id":"3", "name":"name 3", "email":"3@mail.com"}
  ])

  def start_link do
    init_users = Poison.decode!(@users, as: [%UserDto{}])

    Agent.start_link(fn -> init_users end, name: :userStorage)
  end

  def get do
    Agent.get(:userStorage, fn list -> list end)
  end

  def find(userId) do
    Agent.get(:userStorage, fn list -> list end)
    |> Enum.filter( fn(user) -> user.id === userId end)
    |> get_first_or_nil
  end

  defp get_first_or_nil(users) when users == [] do
    nil
  end

  defp get_first_or_nil(users) do
    users
    |> Enum.at(0)
  end
end
