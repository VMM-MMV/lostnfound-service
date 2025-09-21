defmodule MyappWeb.PageController do
  use MyappWeb, :controller

  def home(conn, _params) do
    text(conn, "Hello World")
  end
end
