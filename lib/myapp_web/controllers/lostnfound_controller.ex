defmodule MyappWeb.LostnfoundController do
  use MyappWeb, :controller

  alias Myapp.Lostnfound
  alias Myapp.Lostnfound.Post
  alias MyappWeb.LostnfoundView

  action_fallback MyappWeb.ErrorJSON

  def show(conn, _params) do
    all_posts = Lostnfound.list_posts()
    json(conn, %{posts: all_posts})
  end

  def create(conn, post_params) do
    with {:ok, %Post{} = post} <- Lostnfound.create_post(Map.put(post_params, "user_id", conn.assigns.user_id)) do
      conn
      |> put_status(:created)
      |> json(%{data: LostnfoundView.render_post(post)})
    end
  end

  def update(conn, %{"id" => id, "status" => status}) do
    post = Lostnfound.get_post_by_user_id!(id)

    if post.user_id != conn.assigns.user_id do
      conn
      |> put_status(:forbidden)
      |> json(%{error: "You are not authorized to update this post"})
    else
      with {:ok, %Post{} = post} <- Lostnfound.update_post(post, %{status: status}) do
        json(conn, %{data: LostnfoundView.render_post(post)})
      end
    end
  end
end
