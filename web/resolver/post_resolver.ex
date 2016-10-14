defmodule PhoenixGraphql.Resolver.Post do

  @posts ~s([
    {"id":"1","title":"1", "body":"1"},
    {"id":"2","title":"2", "body":"2"},
    {"id":"3","title":"3", "body":"3"}
  ])

  def all() do
    Poison.decode!(@posts, as: [%PhoenixGraphql.Post{}])
  end

  def all(_args, _info) do
    {:ok, all}
  end

  def find(id) do
    all() |>
    Enum.filter( fn(user) -> user.id === id end) |>
    Enum.at(0)
  end

end
