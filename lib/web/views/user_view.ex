defmodule PhoenixGraphql.UserView do
  use PhoenixGraphql.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, PhoenixGraphql.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, PhoenixGraphql.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      id: user.id,
      name: user.name,
      email: user.email}
  end
end
