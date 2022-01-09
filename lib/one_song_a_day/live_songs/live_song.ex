defmodule OneSongADay.LiveSongs.LiveSong do
  use Ecto.Schema
  import Ecto.Changeset

  schema "live_songs" do
    field :spotify_link, :string
    field :title, :string
    field :youtube_link, :string

    timestamps()
  end

  @doc false
  def changeset(live_song, attrs) do
    live_song
    |> cast(attrs, [:title, :youtube_link, :spotify_link])
    |> validate_required([:title, :youtube_link, :spotify_link])
  end
end
