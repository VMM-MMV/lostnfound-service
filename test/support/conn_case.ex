defmodule MyappWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use MyappWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  import Phoenix.ConnTest, only: [json_response: 2, post: 3]
  import Plug.Conn, only: [put_req_header: 3]

  @endpoint MyappWeb.Endpoint

  using do
    quote do
      # The default endpoint for testing
      @endpoint MyappWeb.Endpoint

      use MyappWeb, :verified_routes

      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import MyappWeb.ConnCase
    end
  end

  setup tags do
    Myapp.DataCase.setup_sandbox(tags)
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

  @doc """
  Builds a conn with an Authorization header containing a JWT token for the given user_id.
  """
  def build_auth_conn(conn, user_id) do
    # Use the TokenController to generate a token
    token_conn =
      post(conn, "/api/token", %{"user_id" => user_id})
      |> json_response(200)

    token = token_conn["token"]

    put_req_header(conn, "authorization", "Bearer #{token}")
  end

  @doc """
  Asserts that a given key in a JSON response satisfies a predicate.
  """
  def assert_in_json_response(conn, status, key, predicate) do
    assert %{^key => value} = json_response(conn, status)
    assert predicate.(value)
  end
end
