defmodule PhoenixGraphql.Router do
  use Phoenix.Router

forward "/", Absinthe.Plug,
  schema: PhoenixGraphql.Schema
  
end
