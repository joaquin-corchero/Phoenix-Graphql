defmodule PhoenixGraphql.Resolver.User do

  @users ~s([{"id":"1", "name":"name 1", "email":"1@mail.com"}, {"id":"2", "name":"name 2", "email":"2@mail.com"}])

  def all(_args, _info) do
    {:ok, get_users}
  end

  defp get_users() do
    Poison.decode!(@users, as: [%PhoenixGraphql.Schema.User{}])
  end

  def find(%{id: id}, _info) do
    {index, _} = Integer.parse(id)

    result =
      get_users |>
      Enum.at(index)

    case result do
      nil -> {:error, "User id #{id} not found"}
      user -> {:ok, user}
    end
  end

end
