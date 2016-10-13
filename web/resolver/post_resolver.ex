defmodule PhoenixGraphql.Resolver.Post do

  @posts ~s([
    {"title":"1", "body":"1"},
    {"title":"2", "body":"2"},
    {"title":"3", "body":"3"}
  ])

  def all(_args, _info) do
    posts = Poison.decode!(@posts, as: [%PhoenixGraphql.Schema.Post{}])
    {:ok, posts}
  end

end
