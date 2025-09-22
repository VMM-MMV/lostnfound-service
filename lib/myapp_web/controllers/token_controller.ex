
defmodule MyappWeb.TokenController do
  use MyappWeb, :controller

  alias Joken.Signer

  def generate_token(conn, %{"user_id" => user_id}) do
    # Create signer with hardcoded secret (for testing only)
    signer = Signer.create("HS256", Application.get_env(:myapp, :jwt_secret, "secret"))

    # Create payload
    payload = %{
      "user_id" => user_id,
      "exp" => :os.system_time(:seconds) + 3600,
      "iat" => :os.system_time(:seconds)
    }

    # Generate token
    {:ok, token, _claims} = Joken.encode_and_sign(payload, signer)

    conn
    |> put_status(200)
    |> json(%{token: token})
  end
end
