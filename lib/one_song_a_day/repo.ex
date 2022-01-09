defmodule OneSongADay.Repo do
  use Ecto.Repo,
    otp_app: :one_song_a_day,
    adapter: Ecto.Adapters.Postgres
end
