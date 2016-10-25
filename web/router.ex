defmodule PhoenixGraphql.Router do
  use Phoenix.Router

  pipeline :graphql do
      plug PhoenixGraphql.Context
  end

  pipeline :api do
      plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api
    get "/posts", PhoenixGraphql.PostController, :index

    pipe_through :graphql

    get "/graphiql", Absinthe.Plug.GraphiQL, schema: PhoenixGraphql.GraphQL.Schema
    post "/graphiql", Absinthe.Plug.GraphiQL, schema: PhoenixGraphql.GraphQL.Schema

    forward "/api", Absinthe.Plug, schema: PhoenixGraphql.GraphQL.Schema
  end
end
