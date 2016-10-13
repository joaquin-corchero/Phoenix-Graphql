defmodule PhoenixGraphql.Schema do
  use Absinthe.Schema
  alias PhoenixGraphql.Resolver

  import_types PhoenixGraphql.Schema.Types

  query do
    @desc "Get all the posts"
    field :posts, list_of(:post) do
      resolve &Resolver.Post.all/2
    end

    @desc "Get a user of the blog"
    field :user, :user do
      arg :id, non_null(:id)
      resolve &Resolver.User.find/2
    end
  end

end
