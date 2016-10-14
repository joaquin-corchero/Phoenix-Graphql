defmodule PhoenixGraphql.PostView do
  use PhoenixGraphql.Web, :view

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PhoenixGraphql.PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PhoenixGraphql.PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      id: post.id,
      title: post.title,
      body: post.body}
  end
end
