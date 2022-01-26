defmodule OneSongADay.Repo.Migrations.UpdateLiveSongsTable do
  use Ecto.Migration

  def change do
    alter table(:live_songs) do
      add :author_tweet, :string
    end
  end
end
