defmodule PhoenixGraphql.Schema do
  use Absinthe.Schema
  alias PhoenixGraphql.Resolver

  import_types PhoenixGraphql.Schema.Types

#http://localhost:4000/api?query=query+getPosts(){post{id,title,body}}
  query do
    @desc "Get all the posts"
    field :posts, list_of(:post) do
      IO.inspect("~~~~~~~~~~~~~~~~~~~~~~~~~")
      resolve &Resolver.Post.all/2
    end

#http://localhost:4000/api?query=query+getUser($id:ID){user(id:$id){id,name,email}}&variables={%22id%22:%220%22}
    @desc "Get a user of the blog"
    field :user, :user do
      IO.inspect("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
      arg :id, non_null(:id)
      resolve &Resolver.User.find/2
    end

    @desc "Get all users"
    field :users, list_of(:user) do
      resolve &Resolver.User.all/2
    end
  end

end
