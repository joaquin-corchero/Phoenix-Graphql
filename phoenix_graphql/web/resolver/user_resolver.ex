defmodule PhoenixGraphql.Resolver.User do

  def find(%{id: id}, _info) do
    content = ~s([{"id":"1", "name":"name 1", "email":"1@mail.com"}, {"id":"2", "name":"name 2", "email":"2@mail.com"}])
    {index, _} = Integer.parse(id)

    result =
      Poison.Parser.parse!(content) |>
      Enum.at(index)

    case result do
      nil -> {:error, "User id #{id} not found"}
      user -> {:ok, user}
    end
  end

end
