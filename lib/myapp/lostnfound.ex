defmodule Myapp.Lostnfound do
  import Ecto.Query, warn: false
  alias Myapp.Repo

  alias Myapp.Lostnfound.Post
  alias Myapp.Lostnfound.Comment

  def list_posts do
    Repo.all(Post)
  end

  def get_post!(id), do: Repo.get!(Post, id)

  def get_post_by_user_id!(user_id), do: Repo.get_by!(Post, user_id: user_id)

  def create_post(attrs) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  def list_comments(post_id) do
    Repo.all(from c in Comment, where: c.post_id == ^post_id)
  end

  def create_comment(attrs) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end
end
