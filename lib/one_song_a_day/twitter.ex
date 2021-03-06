defmodule OneSongADay.Twitter do
  def process_tweet(live_song) do
    if(live_song.tweet_text == nil) do
      default_tweet(live_song)
    else
      live_song.tweet_text
    end
  end

  defp default_tweet(live_song) do
    "🎵 La canción del día ya disponible en #OneSongADay!!

    Hoy os traemos \"#{live_song.title}\" de #{live_song.author}#{if live_song.author_twitter do
      " (@#{live_song.author_twitter})"
    end}!!

    Spotify: #{live_song.spotify_link}

    YouTube: https://youtu.be/#{live_song.youtube_link}"
  end
end
