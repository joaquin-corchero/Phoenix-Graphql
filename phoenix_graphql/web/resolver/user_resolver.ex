defmodule PhoenixGraphql.Resolver.User do

  @users ~s([{"id":"1", "name":"name 1", "email":"1@mail.com"}, {"id":"2", "name":"name 2", "email":"2@mail.com"}])

  def all(_args, _info) do
    Poison.Parser.parse!(@users)
  end

  def find(%{id: id}, _info) do
    #{index, _} = Integer.parse(id)
    index = 0

    result =
      Poison.Parser.parse!(@users) |>
      Enum.at(index)

    IO.inspect result

    case result do
      nil -> {:error, "User id #{id} not found"}
      user -> {:ok, user}
    end
  end

end
