defmodule MyappWeb.Plugs.AuthPlug do
  import Plug.Conn
  import Phoenix.Controller
  alias MyappWeb.Token

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        case Token.verify_and_validate(token) do
          {:ok, %{"user_id" => user_id}} ->
            assign(conn, :user_id, user_id)

          _ ->
            unauthorized(conn)
        end

      _ ->
        unauthorized(conn)
    end
  end

  defp unauthorized(conn) do
    conn
    |> put_status(:unauthorized)
    |> json(%{error: "unauthorized"})
    |> halt()
  end
end
