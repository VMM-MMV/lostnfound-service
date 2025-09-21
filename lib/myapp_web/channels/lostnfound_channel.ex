defmodule MyappWeb.LostnfoundChannel do
  use MyappWeb, :channel

  def join("lostnfound:" <> post_id, _payload, socket) do
    socket = assign(socket, :post_id, post_id)
    {:ok, socket}
  end

  def handle_in("post_message", payload, socket) do
    with {:ok, comment} <- Myapp.Lostnfound.create_comment(%{
          post_id: socket.assigns.post_id,
          user_id: socket.assigns.user_id,
          content: payload["content"]
        }) do
      broadcast!(socket, "post_message", %{
        type: "post_message",
        post_id: socket.assigns.post_id,
        message_id: comment.id,
        user_id: socket.assigns.user_id,
        content: payload["content"],
        ts: comment.inserted_at
      })

      {:reply, {:ok, %{message_id: comment.id}}, socket}
    else
      {:error, reason} ->
        {:reply, {:error, %{reason: reason}}, socket}
    end
  end

  def handle_in("list_messages", _payload, socket) do
    comments = Myapp.Lostnfound.list_comments(socket.assigns.post_id)

    response = Enum.map(comments, fn c ->
      %{
        message_id: c.id,
        post_id: c.post_id,
        user_id: c.user_id,
        content: c.content,
        ts: c.inserted_at
      }
    end)

    {:reply, {:ok, %{messages: response}}, socket}
  end

end
