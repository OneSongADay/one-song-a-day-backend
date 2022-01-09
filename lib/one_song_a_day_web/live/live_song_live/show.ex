defmodule OneSongADayWeb.LiveSongLive.Show do
  use OneSongADayWeb, :live_view

  alias OneSongADay.LiveSongs

  @impl true
  def mount(_params, _session, socket) do
    LiveSongs.subscribe()

    {:ok, fetch(socket)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:live_song, LiveSongs.get_live_song!(id))}
  end

  @impl true
  def handle_info({LiveSongs, [:live_song | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  defp page_title(:show), do: "Show Live song"
  defp page_title(:edit), do: "Edit Live song"

  defp fetch(socket) do
    assign(socket, live_songs: LiveSongs.list_live_songs())
  end
end
