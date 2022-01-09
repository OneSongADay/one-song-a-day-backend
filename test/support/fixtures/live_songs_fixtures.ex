defmodule OneSongADay.LiveSongsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OneSongADay.LiveSongs` context.
  """

  @doc """
  Generate a live_song.
  """
  def live_song_fixture(attrs \\ %{}) do
    {:ok, live_song} =
      attrs
      |> Enum.into(%{
        spotify_link: "some spotify_link",
        title: "some title",
        youtube_link: "some youtube_link"
      })
      |> OneSongADay.LiveSongs.create_live_song()

    live_song
  end
end
