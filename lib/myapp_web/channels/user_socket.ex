defmodule MyappWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "lostnfound:*", MyappWeb.LostnfoundChannel

  def connect(%{"token" => token}, socket, _connect_info) do
    case MyappWeb.Token.verify_and_validate(token) do
      {:ok, %{"user_id" => user_id}} ->
        {:ok, assign(socket, :user_id, user_id)}

      {:error, _reason} ->
        :error
    end
  end

  def connect(_params, _socket, _connect_info), do: :error

  def id(socket), do: "users_socket:#{socket.assigns.user_id}"
end
