defmodule OneSongADayWeb.LiveSongLive.Index do
  use OneSongADayWeb, :live_view

  alias OneSongADay.LiveSongs
  alias OneSongADay.LiveSongs.LiveSong

  @impl true
  def mount(_params, _session, socket) do
    LiveSongs.subscribe()

    {:ok, fetch(socket)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit song")
    |> assign(:live_song, LiveSongs.get_live_song!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New song")
    |> assign(:live_song, %LiveSong{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Live songs")
    |> assign(:live_song, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    live_song = LiveSongs.get_live_song!(id)
    {:ok, _} = LiveSongs.delete_live_song(live_song)

    {:noreply, assign(socket, :live_songs, list_live_songs())}
  end

  @impl true
  def handle_event("show_released_songs", _params, socket) do
    {:noreply,
     assign(socket, live_songs: LiveSongs.list_released_songs(), list_title: 'Old songs')}
  end

  @impl true
  def handle_event("show_future_songs", _params, socket) do
    {:noreply,
     assign(socket, live_songs: LiveSongs.list_live_songs(), list_title: 'Future songs')}
  end

  @impl true
  def handle_info({LiveSongs, [:live_song | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  defp list_live_songs do
    LiveSongs.list_live_songs()
  end

  defp fetch(socket) do
    socket
    |> assign(live_songs: LiveSongs.list_live_songs())
    |> assign(song_of_the_day: LiveSongs.list_song_of_the_day())
    |> assign(list_title: 'Future songs')
  end
end
