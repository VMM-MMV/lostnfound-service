defmodule Myapp.Lostnfound.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :user_id, :string
    field :content, :string
    field :post_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:user_id, :content, :post_id])
    |> validate_required([:user_id, :content, :post_id])
  end
end
