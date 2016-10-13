defmodule PhoenixGraphql.Resolver.Post do

  def all(_args, _info) do
    content = "[{id:10, title:'title 1', body:'body 1'}, {id:20, title:'title 2', body:'body 2'}, {id:30, title:'title 3', body:'body 3'}]"
    IO.inspect("POSTS************************")
    IO.inspect(content)
    {:ok, Poison.Parser.parse!(content)}
  end

end
