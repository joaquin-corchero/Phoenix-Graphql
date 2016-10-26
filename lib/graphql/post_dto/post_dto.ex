defmodule PhoenixGraphql.GraphQL.PostDto do
  use Absinthe.Schema.Notation

  defstruct [
    id: 0,
    title: nil,
    body: nil
  ]

  @desc "A blog post"
  object :post_model do
   field :id, :id
   field :title, :string
   field :body, :string
  end

 def resolve(_args, _info, http_client \\HTTPoison) do
   url = "http://localhost:4000/posts"
   |> http_client.get!
   |> handle_response
 end

 defp handle_response(%{body: body, headers: _, status_code: 200}) do
   posts = body
   |> Poison.decode!(as: %{"data" => [%__MODULE__{}]})
   |> Map.fetch!("data")
   {:ok, posts}
  end

  defp handle_response(%{body: _, headers: _, status_code: 404}) do
    {:error, "Not found"}
  end

  defp handle_response(%{body: body, headers: _, status_code: 500}) do
    {:error, "Internal server error: #{body}"}
  end

  defp handle_response(%{body: body, headers: _, status_code: _}) do
    {:error, "Something wrong happened: #{body}"}
  end

  #def find(id) do
    #all() |>
    #Enum.filter( fn(user) -> user.id === id end) |>
    #Enum.at(0)
  #end

  #def create(%{title: title, body: body}, _info) do
    #{:ok, %__MODULE__{title: title, body: body}}
  #end


end