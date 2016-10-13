defmodule PhoenixGraphql.Router do
  use Phoenix.Router

  pipeline :graphql do
      plug PhoenixGraphql.Context
  end

  scope "/" do
    pipe_through :graphql

    get "/graphiql", Absinthe.Plug.GraphiQL, schema: PhoenixGraphql.Schema
    post "/graphiql", Absinthe.Plug.GraphiQL, schema: PhoenixGraphql.Schema

    forward "/", Absinthe.Plug, schema: PhoenixGraphql.Schema
  end
end
