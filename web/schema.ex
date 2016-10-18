defmodule PhoenixGraphql.Schema do
  use Absinthe.Schema

  import_types PhoenixGraphql.User

  import_types PhoenixGraphql.Post

  query do
    @desc "Get all the posts"
    field :posts, list_of(:post) do
      resolve &PhoenixGraphql.Post.all/2
    end

    @desc "Get all users"
    field :users, list_of(:user) do
      resolve &PhoenixGraphql.User.all/2
    end

    @desc "Get a user of the blog"
    field :user, :user do
      arg :id, non_null(:id)
      resolve &PhoenixGraphql.User.find/2
    end
  end

end
