defmodule Myapp.Lostnfound.PostTest do
  use Myapp.DataCase

  alias Myapp.Lostnfound.Post

  test "changeset with valid attributes" do
    attrs = %{
      description: "some description",
      status: "lost",
      user_id: "user123"
    }
    changeset = Post.changeset(%Post{}, attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    attrs = %{
      description: nil,
      status: nil,
      user_id: nil
    }
    changeset = Post.changeset(%Post{}, attrs)
    refute changeset.valid?
    assert "can't be blank" in errors_on(changeset).description
    assert "can't be blank" in errors_on(changeset).status
    assert "can't be blank" in errors_on(changeset).user_id
  end
end
