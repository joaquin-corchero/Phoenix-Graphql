defmodule PhoenixGraphql.GraphQL.Schemas.PostDto do
  use Absinthe.Schema.Notation

  defstruct [
    id: 0,
    title: nil,
    body: nil
  ]

  @desc "A blog post"
  object :post_model do
   field :id, :id
   field :title, :string
   field :body, :string
 end

 @posts ~s([
   {"id":"1","title":"1", "body":"1"},
   {"id":"2","title":"2", "body":"2"},
   {"id":"3","title":"3", "body":"3"}
 ])

  def all() do
    Poison.decode!(@posts, as: [%__MODULE__{}])
  end

  def all(_args, _info) do
    {:ok, all}
  end

  def find(id) do
    all() |>
    Enum.filter( fn(user) -> user.id === id end) |>
    Enum.at(0)
  end

  def create(%{title: title, body: body}, _info) do
    {:ok, %__MODULE__{title: title, body: body}}
  end


end
