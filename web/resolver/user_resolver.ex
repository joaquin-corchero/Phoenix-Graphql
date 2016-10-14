defmodule PhoenixGraphql.Resolver.User do

  @users ~s([{"id":"1", "name":"name 1", "email":"1@mail.com"}, {"id":"2", "name":"name 2", "email":"2@mail.com"}])

  def all(_args, _info) do
    {:ok, get_users}
  end

  defp get_users() do
    Poison.decode!(@users, as: [%PhoenixGraphql.Schema.User{}])
  end

  def find(%{id: id}, _info) do
    result = find_user(id)

    case result do
      nil -> {:error, "User id #{id} not found"}
      user -> {:ok, user}
    end
  end

  defp find_user(id) do
    get_users |>
    Enum.filter( fn(user) -> user.id === id end) |>
    Enum.at(0)
  end

end
