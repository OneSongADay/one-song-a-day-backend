defmodule OneSongADay.Songs.Song do
  use Ecto.Schema
  import Ecto.Changeset

  schema "songs" do
    field :spotify_link, :string
    field :title, :string
    field :youtube_link, :string

    timestamps()
  end

  @doc false
  def changeset(song, attrs) do
    song
    |> cast(attrs, [:title, :youtube_link, :spotify_link])
    |> validate_required([:title, :youtube_link, :spotify_link])
  end
end
