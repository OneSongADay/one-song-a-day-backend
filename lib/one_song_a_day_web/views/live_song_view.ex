defmodule OneSongADayWeb.LiveSongView do
  use OneSongADayWeb, :view
  alias OneSongADayWeb.LiveSongView
  alias OneSongADay.Twitter

  def render("index.json", %{song_of_the_day: live_song}) do
    %{data: render_one(live_song, LiveSongView, "song_of_the_day.json")}
  end

  def render("song_of_the_day.json", %{live_song: live_song}) do
    %{
      id: live_song.id,
      title: live_song.title,
      author: live_song.author,
      release_date: live_song.release_date,
      spotify_link: live_song.spotify_link,
      youtube_link: live_song.youtube_link,
      tweet: Twitter.process_tweet(live_song)
    }
  end
end
