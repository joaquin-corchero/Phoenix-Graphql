defmodule PhoenixGraphql.UserResolver do

  def find(%{id: id}, _info) do
    content = "[{id:1, name:'name 1', email:'1@mail.com'}, {id:2, name:'2', email:'2@mail.com'}]"

    users = {:ok, Poison.Parser.parse!(content)}

    case Enum.fetch!(users, id) do
      nil -> {:error, "User id #{id} not found"}
      user -> {:ok, user}
    end
  end

end
