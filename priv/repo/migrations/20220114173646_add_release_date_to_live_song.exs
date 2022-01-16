defmodule OneSongADay.Repo.Migrations.AddReleaseDateToLiveSong do
  use Ecto.Migration

  def change do
    alter table("live_songs") do
      add :release_date, :naive_datetime
    end
  end
end
