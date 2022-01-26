defmodule OneSongADay.Repo.Migrations.UpdateLiveSongsTable do
  use Ecto.Migration

  def change do
    alter table(:live_songs) do
      add :author_twitter, :string
    end
  end
end
