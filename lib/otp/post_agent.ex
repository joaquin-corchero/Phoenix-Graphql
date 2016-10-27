defmodule PhoenixGraphql.PostAgent do
  alias PhoenixGraphql.GraphQL.PostDto
#http://elixir-lang.org/getting-started/mix-otp/supervisor-and-application.html
  @posts ~s([
    {"id":"1","title":"1", "body":"1"},
    {"id":"2","title":"2", "body":"2"},
    {"id":"3","title":"3", "body":"3"}
  ])

  def start_link do
    IO.inspect("++++++++++++++++++++")
    IO.inspect("Agent started!!!!")
    IO.inspect("++++++++++++++++++++")
    init_posts = Poison.decode!(@posts, as: [%PostDto{}])

    Agent.start_link(fn -> init_posts end, name: :postStorage)
  end

  def get do
    Agent.get(:postStorage, fn list -> list end)
  end

  def put(new_item) do
    Agent.update(:postStorage, fn list -> [new_item | list] end)
  end

  def stop do
    Agent.stop(:postStorage)
  end
end
