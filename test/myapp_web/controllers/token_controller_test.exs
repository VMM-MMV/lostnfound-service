
defmodule MyappWeb.TokenControllerTest do
  use MyappWeb.ConnCase

  setup do
    conn = build_conn()
    {:ok, conn: conn}
  end

  test "creates a JWT token", %{conn: conn} do
    conn = post(conn, "/api/token", %{"user_id" => "test_user_id"})
    assert json_response(conn, 200)["jwt"]
  end
end
