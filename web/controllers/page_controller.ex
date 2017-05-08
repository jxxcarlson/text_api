defmodule TextApi.PageController do
  use TextApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
