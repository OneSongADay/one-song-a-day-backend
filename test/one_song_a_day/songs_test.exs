defmodule OneSongADay.SongsTest do
  use OneSongADay.DataCase

  alias OneSongADay.Songs

  describe "songs" do
    alias OneSongADay.Songs.Song

    import OneSongADay.SongsFixtures

    @invalid_attrs %{spotify_link: nil, title: nil, youtube_link: nil}

    test "list_songs/0 returns all songs" do
      song = song_fixture()
      assert Songs.list_songs() == [song]
    end

    test "get_song!/1 returns the song with given id" do
      song = song_fixture()
      assert Songs.get_song!(song.id) == song
    end

    test "create_song/1 with valid data creates a song" do
      valid_attrs = %{spotify_link: "some spotify_link", title: "some title", youtube_link: "some youtube_link"}

      assert {:ok, %Song{} = song} = Songs.create_song(valid_attrs)
      assert song.spotify_link == "some spotify_link"
      assert song.title == "some title"
      assert song.youtube_link == "some youtube_link"
    end

    test "create_song/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Songs.create_song(@invalid_attrs)
    end

    test "update_song/2 with valid data updates the song" do
      song = song_fixture()
      update_attrs = %{spotify_link: "some updated spotify_link", title: "some updated title", youtube_link: "some updated youtube_link"}

      assert {:ok, %Song{} = song} = Songs.update_song(song, update_attrs)
      assert song.spotify_link == "some updated spotify_link"
      assert song.title == "some updated title"
      assert song.youtube_link == "some updated youtube_link"
    end

    test "update_song/2 with invalid data returns error changeset" do
      song = song_fixture()
      assert {:error, %Ecto.Changeset{}} = Songs.update_song(song, @invalid_attrs)
      assert song == Songs.get_song!(song.id)
    end

    test "delete_song/1 deletes the song" do
      song = song_fixture()
      assert {:ok, %Song{}} = Songs.delete_song(song)
      assert_raise Ecto.NoResultsError, fn -> Songs.get_song!(song.id) end
    end

    test "change_song/1 returns a song changeset" do
      song = song_fixture()
      assert %Ecto.Changeset{} = Songs.change_song(song)
    end
  end
end
