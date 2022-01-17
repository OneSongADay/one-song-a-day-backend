defmodule OneSongADayWeb.LiveSongLive.Released do
  use OneSongADayWeb, :live_view

  alias OneSongADay.LiveSongs

  @impl true
  def mount(_params, _session, socket) do
    LiveSongs.subscribe()

    {:ok, assign(fetch(socket), :live_songs, list_live_songs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :released, _params) do
    socket
    |> assign(:page_title, "Admin panel - released songs")
    |> assign(:live_song, nil)
  end

  @impl true
  def handle_info({LiveSongs, [:live_song | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  defp list_live_songs do
    LiveSongs.list_released_songs()
  end

  defp fetch(socket) do
    assign(socket, live_songs: LiveSongs.list_released_songs())
  end
end
