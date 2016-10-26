defmodule PhoenixGraphql.PostController do
  use PhoenixGraphql.Web, :controller

  alias PhoenixGraphql.GraphQL.PostDto
  alias PhoenixGraphql.PostAgent

  def index(conn, _params) do
    render(conn, "index.json", posts: PostAgent.get)
  end

  def create(conn, %{"post" => post_params}) do
    IO.inspect post_params
    PhoenixGraphql.PostAgent.put(%PostDto{id: 100, title: "the title", body: "This is a very long body"} )
    render(conn, "index.json", posts: PostAgent.get)
  end

  def show(conn, %{"id" => id}) do
    post = PostDto.find(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    #post = Repo.get!(Post, id)
    #changeset = Post.changeset(post, post_params)

    #case Repo.update(changeset) do
    #  {:ok, post} ->
    #    render(conn, "show.json", post: post)
    #  {:error, changeset} ->
    #    conn
    #    |> put_status(:unprocessable_entity)
    #    |> render(PhoenixGraphql.ChangesetView, "error.json", changeset: changeset)
    #end
  end

  def delete(conn, %{"id" => id}) do
    #post = Repo.get!(Post, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    #Repo.delete!(post)

    send_resp(conn, :no_content, "")
  end
end
