defmodule OneSongADay.Repo.Migrations.ChangeReleaseDateToDateType do
  use Ecto.Migration

  def change do
    alter table(:live_songs) do
      modify :release_date, :date
    end
  end
end
