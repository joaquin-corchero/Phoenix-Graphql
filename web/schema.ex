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

    @desc "Get all users"
    field :users, list_of(:user) do
      IO.inspect("++++++++++++++++++++++++++")
      resolve &Resolver.User.all/2
    end
#http://localhost:4000/api?query=query+getUser($id:ID){user(id:$id){id,name,email}}&variables={%22id%22:%220%22}
#http://localhost:4000/graphiql?query=query%20getUser(%24id%3A%20ID)%20%7B%0A%20%20user(id%3A%20%24id)%20%7B%0A%20%20%20%20id%0A%20%20%20%20name%0A%20%20%20%20email%0A%20%20%7D%0A%7D%0A&variables=%7B%22id%22%3A%20%22pp%22%7D
    @desc "Get a user of the blog"
    field :user, :user do
      IO.inspect("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
      arg :id, non_null(:id)
      resolve &Resolver.User.find/2
    end
  end

end
