defmodule OneSongADayWeb.LiveSongController do
  use OneSongADayWeb, :controller

  alias OneSongADay.LiveSongs

  action_fallback OneSongADayWeb.FallbackController

  def index(conn, _params) do
    live_song = LiveSongs.list_song_of_the_day()
    render(conn, "index.json", song_of_the_day: live_song)
  end
end
