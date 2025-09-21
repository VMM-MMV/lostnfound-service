
defmodule MyappWeb.Plugs.AuthPlug do
  import Plug.Conn

  def init(opts), do: opts

  @spec call(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, %{"user_id" => user_id}} <- MyappWeb.Token.verify_and_validate(token)
    do
      assign(conn, :user_id, user_id)
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> halt()
    end
  end
end
