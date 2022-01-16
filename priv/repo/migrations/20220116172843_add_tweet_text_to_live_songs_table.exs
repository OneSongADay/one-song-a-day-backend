defmodule OneSongADay.Repo.Migrations.AddTweetTextToLiveSongsTable do
  use Ecto.Migration

  def change do
    alter table("live_songs") do
      add :tweet_text, :string
    end
  end
end
