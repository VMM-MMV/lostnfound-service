defmodule MyappWeb.Plugs.AuthPlugTest do
  use MyappWeb.ConnCase

  import Plug.Conn

  setup %{conn: conn} do
    {:ok, conn: conn}
  end

  @tag :skip
  test "halts the connection and returns unauthorized if no authorization header is present", %{conn: conn} do
    conn = MyappWeb.Plugs.AuthPlug.call(conn, [])
    assert conn.state == :halted
    assert conn.status == 401
    assert json_response(conn, 401)["error"] == "unauthorized"
  end

  @tag :skip
  test "halts the connection and returns unauthorized if authorization header is not Bearer", %{conn: conn} do
    conn =
      conn
      |> put_req_header("authorization", "Basic some_token")
      |> MyappWeb.Plugs.AuthPlug.call([])

    assert conn.state == :halted
    assert conn.status == 401
    assert json_response(conn, 401)["error"] == "unauthorized"
  end

  @tag :skip
  test "halts the connection and returns unauthorized if JWT token is invalid", %{conn: conn} do
    conn =
      conn
      |> put_req_header("authorization", "Bearer invalid_token")
      |> MyappWeb.Plugs.AuthPlug.call([])

    assert conn.state == :halted
    assert conn.status == 401
    assert json_response(conn, 401)["error"] == "unauthorized"
  end

  @tag :skip
  test "assigns user_id to conn if JWT token is valid", %{conn: conn} do
    conn = build_auth_conn(conn, "test_user_id")
    conn = MyappWeb.Plugs.AuthPlug.call(conn, [])
    assert conn.state == :unset # Should be :unset after assign
    assert conn.assigns.user_id == "test_user_id"
  end
end
