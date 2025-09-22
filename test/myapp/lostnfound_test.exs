defmodule Myapp.LostnfoundTest do
  use Myapp.DataCase

  alias Myapp.Lostnfound
  alias Myapp.Lostnfound.Post

  @moduletag :database

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Myapp.Repo)
  end

  defp post_fixture(attrs) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        description: "some description",
        status: "lost",
        user_id: "user123"
      })
      |> Myapp.Lostnfound.create_post()

    post
  end

  test "list_posts/0 returns all posts" do
    post = post_fixture(%{})
    assert Myapp.Lostnfound.list_posts() == [post]
  end

  test "get_post!/1 returns the post with given id" do
    post = post_fixture(%{})
    assert Myapp.Lostnfound.get_post!(post.id) == post
  end

  test "create_post/1 with valid data creates a post" do
    assert {:ok, %Post{} = post} = Myapp.Lostnfound.create_post(%{description: "some description", status: "lost", user_id: "user123"})
    assert post.description == "some description"
    assert post.status == "lost"
    assert post.user_id == "user123"
  end

  test "update_post/2 with valid data updates the post" do
    post = post_fixture(%{})
    assert {:ok, %Post{} = post} = Myapp.Lostnfound.update_post(post, %{status: "found"})
    assert post.status == "found"
  end

  test "delete_post/1 deletes the post" do
    post = post_fixture(%{})
    assert {:ok, %Post{}} = Myapp.Lostnfound.delete_post(post)
    assert_raise Ecto.NoResultsError, fn -> Myapp.Lostnfound.get_post!(post.id) end
  end

  test "change_post/1 returns a post changeset" do
    post = post_fixture(%{})
    assert %Ecto.Changeset{} = Myapp.Lostnfound.change_post(post)
  end

  defp comment_fixture(post, attrs) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        content: "some content",
        post_id: post.id,
        user_id: "user123"
      })
      |> Myapp.Lostnfound.create_comment()

    comment
  end

  test "list_comments/1 returns all comments for a post" do
    post = post_fixture(%{})
    comment = comment_fixture(post, %{})
    assert Myapp.Lostnfound.list_comments(post.id) == [comment]
  end

  test "create_comment/1 with valid data creates a comment" do
    post = post_fixture(%{})
    assert {:ok, %Myapp.Lostnfound.Comment{} = comment} = Myapp.Lostnfound.create_comment(%{content: "some content", post_id: post.id, user_id: "user123"})
    assert comment.content == "some content"
    assert comment.post_id == post.id
    assert comment.user_id == "user123"
  end
end
