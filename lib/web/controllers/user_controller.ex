defmodule PhoenixGraphql.UserController do
  use PhoenixGraphql.Web, :controller

  alias PhoenixGraphql.GraphQL.UserDto
  alias PhoenixGraphql.UserAgent

  def index(conn, _params) do
    render(conn, "index.json", users: UserAgent.get)
  end

  def show(conn, %{"id" => id}) do
    user = UserAgent.find(id)
    render(conn, "show.json", user: user)
  end

end
