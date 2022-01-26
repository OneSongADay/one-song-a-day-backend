defmodule OneSongADay.Repo.Migrations.ModifyAuthorTweetFieldInLiveSongsTable do
  use Ecto.Migration

  def change do
    alter table(:live_songs) do
      add :author_twitter, :string
      remove :author_twitter
    end
  end
end
