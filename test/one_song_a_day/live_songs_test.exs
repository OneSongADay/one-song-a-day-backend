defmodule OneSongADay.LiveSongsTest do
  use OneSongADay.DataCase

  alias OneSongADay.LiveSongs

  describe "live_songs" do
    alias OneSongADay.LiveSongs.LiveSong

    import OneSongADay.LiveSongsFixtures

    @invalid_attrs %{spotify_link: nil, title: nil, youtube_link: nil}

    test "list_live_songs/0 returns all live_songs" do
      live_song = live_song_fixture()
      assert LiveSongs.list_live_songs() == [live_song]
    end

    test "get_live_song!/1 returns the live_song with given id" do
      live_song = live_song_fixture()
      assert LiveSongs.get_live_song!(live_song.id) == live_song
    end

    test "create_live_song/1 with valid data creates a live_song" do
      valid_attrs = %{spotify_link: "some spotify_link", title: "some title", youtube_link: "some youtube_link"}

      assert {:ok, %LiveSong{} = live_song} = LiveSongs.create_live_song(valid_attrs)
      assert live_song.spotify_link == "some spotify_link"
      assert live_song.title == "some title"
      assert live_song.youtube_link == "some youtube_link"
    end

    test "create_live_song/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LiveSongs.create_live_song(@invalid_attrs)
    end

    test "update_live_song/2 with valid data updates the live_song" do
      live_song = live_song_fixture()
      update_attrs = %{spotify_link: "some updated spotify_link", title: "some updated title", youtube_link: "some updated youtube_link"}

      assert {:ok, %LiveSong{} = live_song} = LiveSongs.update_live_song(live_song, update_attrs)
      assert live_song.spotify_link == "some updated spotify_link"
      assert live_song.title == "some updated title"
      assert live_song.youtube_link == "some updated youtube_link"
    end

    test "update_live_song/2 with invalid data returns error changeset" do
      live_song = live_song_fixture()
      assert {:error, %Ecto.Changeset{}} = LiveSongs.update_live_song(live_song, @invalid_attrs)
      assert live_song == LiveSongs.get_live_song!(live_song.id)
    end

    test "delete_live_song/1 deletes the live_song" do
      live_song = live_song_fixture()
      assert {:ok, %LiveSong{}} = LiveSongs.delete_live_song(live_song)
      assert_raise Ecto.NoResultsError, fn -> LiveSongs.get_live_song!(live_song.id) end
    end

    test "change_live_song/1 returns a live_song changeset" do
      live_song = live_song_fixture()
      assert %Ecto.Changeset{} = LiveSongs.change_live_song(live_song)
    end
  end
end
