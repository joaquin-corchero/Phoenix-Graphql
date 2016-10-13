defmodule PhoenixGraphql.Schema do
  use Absinthe.Schema
  import_types PhoenixGraphql.Schema.Types

  query do
    @desc "Get all the posts"
    field :posts, list_of(:post) do
      resolve &PhoenixGraphql.PostResolver.all/2
    end

    @desc "Get a user of the blog"
    field :user, type: :user do
      arg :id, non_null(:id)
      resolve &PhoenixGraphql.UserResolver.find/2
    end

  end

end
