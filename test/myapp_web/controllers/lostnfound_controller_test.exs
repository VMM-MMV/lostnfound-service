defmodule MyappWeb.LostnfoundControllerTest do
  use MyappWeb.ConnCase

  alias Myapp.Lostnfound

  @jwt "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidXNlcjEyMyJ9.YKFeQyGqcnhJY1oG7y1gYPEWJILPBAW0oo827i32eHY"

  defp create_post(_) do
    post = fixture(%{
      description: "some description",
      status: "lost",
      user_id: "user123"
    })
    {:ok, post: post}
  end

  defp fixture(attrs) do
    {:ok, post} = Lostnfound.create_post(attrs)
    post
  end

  describe "show/2" do
    test "returns all posts", %{conn: conn} do
      conn = conn
      |> put_req_header("authorization", "Bearer " <> @jwt)
      |> get("/api/lostnfound")
      assert json_response(conn, 200)["posts"] == []
    end
  end

  describe "create/2" do
    test "creates a post when data is valid", %{conn: conn} do
      conn = conn
      |> put_req_header("authorization", "Bearer " <> @jwt)
      |> post("/api/lostnfound", %{
        "description" => "some description",
        "status" => "lost"
      })

    assert %{"data" => data} = json_response(conn, 201)

    assert data["description"] == "some description"
    assert data["status"] == "lost"
    assert data["user_id"] == "user123"
    end
  end

  describe "update/2" do
    setup [:create_post]

    test "updates post when data is valid", %{conn: conn, post: post} do
      conn = conn
      |> put_req_header("authorization", "Bearer " <> @jwt)
      |> patch("/api/lostnfound/#{post.id}", %{"status" => "found"})

      assert %{"data" => data} = json_response(conn, 200)

      assert data["status"] == "found"
    end

    test "returns error when user is not authorized", %{conn: conn, post: post} do
      signer = Joken.Signer.create("HS256", "secret")
      {:ok, new_token, _claims} = Joken.generate_and_sign(%{"user_id" => "user456"}, %{}, signer)

      conn = conn
      |> put_req_header("authorization", "Bearer " <> new_token)
      |> patch("/api/lostnfound/#{post.id}", %{"status" => "found"})

      assert conn.status == 401
    end
  end
end
