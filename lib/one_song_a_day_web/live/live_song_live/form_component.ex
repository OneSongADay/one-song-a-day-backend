defmodule OneSongADayWeb.LiveSongLive.FormComponent do
  use OneSongADayWeb, :live_component

  alias OneSongADay.LiveSongs

  @impl true
  def update(%{live_song: live_song} = assigns, socket) do
    changeset = LiveSongs.change_live_song(live_song)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"live_song" => live_song_params}, socket) do
    changeset =
      socket.assigns.live_song
      |> LiveSongs.change_live_song(live_song_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"live_song" => live_song_params}, socket) do
    save_live_song(socket, socket.assigns.action, live_song_params)
  end

  defp save_live_song(socket, :edit, live_song_params) do
    case LiveSongs.update_live_song(socket.assigns.live_song, live_song_params) do
      {:ok, _live_song} ->
        {:noreply,
         socket
         |> put_flash(:info, "Live song updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_live_song(socket, :new, live_song_params) do
    case LiveSongs.create_live_song(live_song_params) do
      {:ok, _live_song} ->
        {:noreply,
         socket
         |> put_flash(:info, "Live song created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
