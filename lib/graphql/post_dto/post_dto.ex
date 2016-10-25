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

 @posts ~s([
   {"id":"1","title":"1", "body":"1"},
   {"id":"2","title":"2", "body":"2"},
   {"id":"3","title":"3", "body":"3"}
 ])

 def resolve(_args, _info, http_client \\HTTPoison) do
   url = "http://localhost:4000/posts"
   |> http_client.get
   |> handle_response
 end

 defp handle_response({:ok, %HTTPoison.Response{body: {body}, status_code: 200}}) do
   IO.inspect "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
   IO.inspect body
    post = body
    #|> Poison.decode!(as: [%__MODULE__{}])
    {:ok, body}
  end

  defp handle_response({:ok, something}) do
    IO.inspect "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    IO.inspect something

    {:error, "Bad request"}
  end

  defp handle_response({:error, _}) do
    {:error, "Something went wrong"}
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
