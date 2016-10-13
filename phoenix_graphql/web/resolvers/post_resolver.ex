defmodule PhoenixGraphql.PostResolver do

  def all(_args, _info) do
    content = "[{id:1, title:'title 1', body:'body 1'}, {id:2, title:'title 2', body:'body 2'}, {id:3, title:'title 3', body:'body 3'}]"

    {:ok, Poison.Parser.parse!(content)}
  end

end
