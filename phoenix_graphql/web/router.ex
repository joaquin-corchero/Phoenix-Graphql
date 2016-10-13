defmodule PhoenixGraphql.Router do
  use Phoenix.Router

  pipeline :graphql do
      plug PhoenixGraphql.Context
  end

  scope "/api" do
    pipe_through :graphql

    forward "/", Absinthe.Plug, schema: PhoenixGraphql.Schema
  end
end
