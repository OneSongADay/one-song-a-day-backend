defmodule OneSongADayWeb.PageController do
  use OneSongADayWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
