defmodule PhoenixGraphql.PostController do
  use PhoenixGraphql.Web, :controller

  alias PhoenixGraphql.GraphQL.Schemas.PostDto

  @posts ~s([
    {"id":"1","title":"1", "body":"1"},
    {"id":"2","title":"2", "body":"2"},
    {"id":"3","title":"3", "body":"3"}
  ])

  def index(conn, _params) do
    IO.inspect("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    render(conn, "index.json", posts: get_posts)
  end

  defp get_posts() do
    Poison.decode!(@posts, as: [%PostDto{}])
  end

  def create(conn, %{"post" => post_params}) do
    #changeset = Post.changeset(%Post{}, post_params)

    #case Repo.insert(changeset) do
    #  {:ok, post} ->
    #    conn
    #    |> put_status(:created)
    #    |> put_resp_header("location", post_path(conn, :show, post))
    #    |> render("show.json", post: post)
    #  {:error, changeset} ->
    #    conn
    #    |> put_status(:unprocessable_entity)
    #    |> render(PhoenixGraphql.ChangesetView, "error.json", changeset: changeset)
    #end
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
