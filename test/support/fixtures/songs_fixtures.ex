defmodule OneSongADay.SongsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OneSongADay.Songs` context.
  """

  @doc """
  Generate a song.
  """
  def song_fixture(attrs \\ %{}) do
    {:ok, song} =
      attrs
      |> Enum.into(%{
        spotify_link: "some spotify_link",
        title: "some title",
        youtube_link: "some youtube_link"
      })
      |> OneSongADay.Songs.create_song()

    song
  end
end
