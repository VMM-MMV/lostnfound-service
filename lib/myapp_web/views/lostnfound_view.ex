defmodule MyappWeb.LostnfoundView do
  def render_post(post) do
    %{
      id: post.id,
      user_id: post.user_id,
      status: post.status,
      description: post.description,
      inserted_at: post.inserted_at,
      updated_at: post.updated_at
    }
  end
end