defmodule OneSongADayWeb.LiveSongLiveTest do
  use OneSongADayWeb.ConnCase

  import Phoenix.LiveViewTest
  import OneSongADay.LiveSongsFixtures

  @create_attrs %{spotify_link: "some spotify_link", title: "some title", youtube_link: "some youtube_link"}
  @update_attrs %{spotify_link: "some updated spotify_link", title: "some updated title", youtube_link: "some updated youtube_link"}
  @invalid_attrs %{spotify_link: nil, title: nil, youtube_link: nil}

  defp create_live_song(_) do
    live_song = live_song_fixture()
    %{live_song: live_song}
  end

  describe "Index" do
    setup [:create_live_song]

    test "lists all live_songs", %{conn: conn, live_song: live_song} do
      {:ok, _index_live, html} = live(conn, Routes.live_song_index_path(conn, :index))

      assert html =~ "Listing Live songs"
      assert html =~ live_song.spotify_link
    end

    test "saves new live_song", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.live_song_index_path(conn, :index))

      assert index_live |> element("a", "New Live song") |> render_click() =~
               "New Live song"

      assert_patch(index_live, Routes.live_song_index_path(conn, :new))

      assert index_live
             |> form("#live_song-form", live_song: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#live_song-form", live_song: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.live_song_index_path(conn, :index))

      assert html =~ "Live song created successfully"
      assert html =~ "some spotify_link"
    end

    test "updates live_song in listing", %{conn: conn, live_song: live_song} do
      {:ok, index_live, _html} = live(conn, Routes.live_song_index_path(conn, :index))

      assert index_live |> element("#live_song-#{live_song.id} a", "Edit") |> render_click() =~
               "Edit Live song"

      assert_patch(index_live, Routes.live_song_index_path(conn, :edit, live_song))

      assert index_live
             |> form("#live_song-form", live_song: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#live_song-form", live_song: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.live_song_index_path(conn, :index))

      assert html =~ "Live song updated successfully"
      assert html =~ "some updated spotify_link"
    end

    test "deletes live_song in listing", %{conn: conn, live_song: live_song} do
      {:ok, index_live, _html} = live(conn, Routes.live_song_index_path(conn, :index))

      assert index_live |> element("#live_song-#{live_song.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#live_song-#{live_song.id}")
    end
  end

  describe "Show" do
    setup [:create_live_song]

    test "displays live_song", %{conn: conn, live_song: live_song} do
      {:ok, _show_live, html} = live(conn, Routes.live_song_show_path(conn, :show, live_song))

      assert html =~ "Show Live song"
      assert html =~ live_song.spotify_link
    end

    test "updates live_song within modal", %{conn: conn, live_song: live_song} do
      {:ok, show_live, _html} = live(conn, Routes.live_song_show_path(conn, :show, live_song))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Live song"

      assert_patch(show_live, Routes.live_song_show_path(conn, :edit, live_song))

      assert show_live
             |> form("#live_song-form", live_song: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#live_song-form", live_song: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.live_song_show_path(conn, :show, live_song))

      assert html =~ "Live song updated successfully"
      assert html =~ "some updated spotify_link"
    end
  end
end
