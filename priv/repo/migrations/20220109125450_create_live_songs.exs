defmodule OneSongADay.Repo.Migrations.CreateLiveSongs do
  use Ecto.Migration

  def change do
    create table(:live_songs) do
      add :title, :string
      add :youtube_link, :string
      add :spotify_link, :string

      timestamps()
    end
  end
end
