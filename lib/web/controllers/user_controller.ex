defmodule PhoenixGraphql.UserController do
  use PhoenixGraphql.Web, :controller

  alias PhoenixGraphql.GraphQL.UserDto
  alias PhoenixGraphql.UserAgent

  def index(conn, _params, user_agent \\UserAgent.get) do
    render(conn, "index.json", users: user_agent)
  end

  def show(conn, %{"id" => id}) do
    user = UserAgent.find(id)
    render(conn, "show.json", user: user)
  end

end
