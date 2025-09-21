defmodule MyappWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "lostnfound:*", MyappWeb.LostnfoundChannel

  def connect(%{"token" => _token}, socket, _connect_info) do
    {:ok, assign(socket, :user_id, "test-user")}
  end

  def connect(_params, _socket, _connect_info), do: :error

  def id(socket), do: "users_socket:#{socket.assigns.user_id}"
end
