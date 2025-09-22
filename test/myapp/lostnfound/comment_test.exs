defmodule Myapp.Lostnfound.CommentTest do
  use Myapp.DataCase

  alias Myapp.Lostnfound.Comment

  test "changeset with valid attributes" do
    attrs = %{
      content: "some content",
      post_id: 1,
      user_id: "user123"
    }
    changeset = Comment.changeset(%Comment{}, attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    attrs = %{
      content: nil,
      post_id: nil,
      user_id: nil
    }
    changeset = Comment.changeset(%Comment{}, attrs)
    refute changeset.valid?
    assert "can't be blank" in errors_on(changeset).content
    assert "can't be blank" in errors_on(changeset).post_id
    assert "can't be blank" in errors_on(changeset).user_id
  end
end
