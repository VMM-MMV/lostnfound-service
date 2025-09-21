defmodule Myapp.Lostnfound.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:user_id, :status, :description]}

  schema "posts" do
    field :user_id, :string
    field :status, :string
    field :description, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:user_id, :status, :description])
    |> validate_required([:user_id, :status, :description])
  end
end
