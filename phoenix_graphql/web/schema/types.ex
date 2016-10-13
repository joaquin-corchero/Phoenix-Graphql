defmodule PhoenixGraphql.Schema.Types do
  use Absinthe.Schema.Notation

  @desc "A blog user"
  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    field :posts, list_of(:post)
  end

  @desc "A blog post"
  object :post do
    field :id, :id
    field :title, :string
    field :body, :string
    field :author, :user
  end
end
