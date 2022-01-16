defmodule OneSongADay.Repo.Migrations.AddAuthorToLiveSongsTable do
  use Ecto.Migration

  def change do
    alter table("live_songs") do
      add :author, :string
    end
  end
end
