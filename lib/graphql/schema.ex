defmodule PhoenixGraphql.GraphQL.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema

  alias PhoenixGraphql.GraphQL.Schemas.UserDto
  alias PhoenixGraphql.GraphQL.Schemas.PostDto

  import_types PhoenixGraphql.GraphQL.Schemas.UserDto
  import_types PhoenixGraphql.GraphQL.Schemas.PostDto

  query do
    @desc "Get all the posts"
    field :posts, list_of(:post_model) do
      resolve &PostDto.all/2
    end

    @desc "Get all users"
    field :users, list_of(:user_model) do
      resolve &UserDto.all/2
    end

    @desc "Get a user of the blog"
    field :user, :user_model do
      arg :id, non_null(:id)
      resolve &UserDto.find/2
    end
  end

  mutation do
    payload field :post_model do
      input do
        field :title, non_null(:string)
        field :body, non_null(:string)
      end
      output do
        field :title, :string
        field :body, :string
      end
      resolve &PostDto.create/2
    end
  end

end
