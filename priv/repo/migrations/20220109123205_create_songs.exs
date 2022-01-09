defmodule OneSongADay.Repo.Migrations.CreateSongs do
  use Ecto.Migration

  def change do
    create table(:songs) do
      add :title, :string
      add :youtube_link, :string
      add :spotify_link, :string

      timestamps()
    end
  end
end
