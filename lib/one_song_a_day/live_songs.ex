defmodule OneSongADay.LiveSongs do
  @moduledoc """
  The LiveSongs context.
  """

  import Ecto.Query, warn: false

  alias OneSongADay.Repo

  alias OneSongADay.LiveSongs.LiveSong

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(OneSongADay.PubSub, @topic)
  end

  @doc """
  Returns the list of live_songs.

  ## Examples

      iex> list_live_songs()
      [%LiveSong{}, ...]

  """
  def list_live_songs do
    ExTwitter.search("elixir-lang", count: 5)
    |> Enum.map(fn tweet -> tweet.text end)
    |> Enum.join("\n-----\n")
    |> IO.puts()

    query =
      from s in LiveSong,
        select:
          struct(s, [
            :id,
            :title,
            :youtube_link,
            :spotify_link,
            :release_date,
            :tweet_text,
            :author
          ]),
        where: s.release_date > ^NaiveDateTime.utc_now(),
        order_by: [asc: :release_date]

    Repo.all(query)
  end

  @doc """
  Gets a single live_song.

  Raises `Ecto.NoResultsError` if the song does not exist.

  ## Examples

      iex> get_live_song!(123)
      %LiveSong{}

      iex> get_live_song!(456)
      ** (Ecto.NoResultsError)

  """
  def get_live_song!(id), do: Repo.get!(LiveSong, id)

  def list_song_of_the_day do
    query =
      from s in LiveSong,
        select:
          struct(s, [
            :id,
            :title,
            :youtube_link,
            :spotify_link,
            :release_date,
            :tweet_text,
            :author
          ]),
        where: s.release_date > ^NaiveDateTime.utc_now(),
        order_by: [asc: :release_date],
        limit: 1

    Repo.one(query)
  end

  @doc """
  Creates a live_song.

  ## Examples

      iex> create_live_song(%{field: value})
      {:ok, %LiveSong{}}

      iex> create_live_song(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_live_song(attrs \\ %{}) do
    %LiveSong{}
    |> LiveSong.changeset(attrs)
    |> Repo.insert()
    |> broadcast_change([:live_song, :created])
  end

  @doc """
  Updates a live_song.

  ## Examples

      iex> update_live_song(live_song, %{field: new_value})
      {:ok, %LiveSong{}}

      iex> update_live_song(live_song, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_live_song(%LiveSong{} = live_song, attrs) do
    live_song
    |> LiveSong.changeset(attrs)
    |> Repo.update()
    |> broadcast_change([:live_song, :updated])
  end

  @doc """
  Deletes a live_song.

  ## Examples

      iex> delete_live_song(live_song)
      {:ok, %LiveSong{}}

      iex> delete_live_song(live_song)
      {:error, %Ecto.Changeset{}}

  """
  def delete_live_song(%LiveSong{} = live_song) do
    live_song
    |> Repo.delete()
    |> broadcast_change([:live_song, :deleted])
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking live_song changes.

  ## Examples

      iex> change_live_song(live_song)
      %Ecto.Changeset{data: %LiveSong{}}

  """
  def change_live_song(%LiveSong{} = live_song, attrs \\ %{}) do
    LiveSong.changeset(live_song, attrs)
  end

  defp broadcast_change({:ok, result}, event) do
    Phoenix.PubSub.broadcast(OneSongADay.PubSub, @topic, {__MODULE__, event, result})

    {:ok, result}
  end
end
