defmodule PhoenixGraphql.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema

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

  mutation do
    payload field :post do
      input do
        field :title, non_null(:string)
        field :body, non_null(:string)
      end
      output do
        field :title, :string
        field :body, :string
      end
      resolve &PhoenixGraphql.Post.create/2
    end
  end

end
