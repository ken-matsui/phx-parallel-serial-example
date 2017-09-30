defmodule ParallelSerialWeb.PageController do
  use ParallelSerialWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
