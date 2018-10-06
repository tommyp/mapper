defmodule MapperWeb.PageController do
  use MapperWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
