defmodule PhoenixGraphql.GraphQL.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema

  alias PhoenixGraphql.GraphQL.Schemas.UserDto
  alias PhoenixGraphql.GraphQL.Schemas.PostDto

  import_types PhoenixGraphql.GraphQL.Schemas.UserDto
  import_types PhoenixGraphql.GraphQL.Schemas.PostDto

  defstruct [
    posts: nil,
    users: nil,
    filtered_user: nil
  ]

  def resolve(_,_), do: {:ok, %__MODULE__{}}

  query do
    field :root, :root do
      description "Root Relay node. All Relay data goes under here"
      resolve &resolve/2
    end
    node field do
      resolve &resolve_node/2
    end
  end

  defp resolve_node(%{type: :root, id: id}, _),
    do: resolve(%{id: id}, nil)
    node interface do
      resolve_type fn
        %__MODULE__{}, _ ->
          :root
        _, _ ->
          nil
    end
  end

  node object :root, description: "All resolvers got here" do
    @desc "Get all the posts"
    field :posts, list_of(:post_model) do
      resolve &PostDto.all/2
    end

    @desc "Get all users"
    field :users, list_of(:user_model) do
      resolve &UserDto.all/2
    end

    @desc "User to be filtered"
    field :filtered_user, :user_model do
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
