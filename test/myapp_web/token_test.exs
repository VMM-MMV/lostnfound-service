defmodule MyappWeb.TokenTest do
  use MyappWeb.ConnCase

  alias MyappWeb.Token
  import Joken
  import Joken.Signer

  @secret "secret"

  test "verify_and_validate/1 with an invalid token" do
    {:error, _} = Token.verify_and_validate("invalid_token")
  end

  test "verify_and_validate/1 with a token signed with a different secret" do
    # Generate a token with a different secret
    signer = Joken.Signer.create("HS256", "wrong_secret")
    {:ok, token, _claims} = Joken.generate_and_sign(%{"user_id" => "user123"}, %{}, signer)

    {:error, _} = Token.verify_and_validate(token)
  end
end
