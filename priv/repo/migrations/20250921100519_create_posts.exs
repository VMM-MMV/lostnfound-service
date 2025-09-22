defmodule Myapp.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :user_id, :string
      add :status, :string, default: "unresolved"
      add :description, :text

      timestamps(type: :utc_datetime)
    end
  end
end
