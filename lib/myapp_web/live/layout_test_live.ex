defmodule MyappWeb.LayoutTestLive do
  use MyappWeb, :live_view

  def render(assigns) do
    ~H"""
    <MyappWeb.Layouts.app flash={%{"info" => "Test Flash Message"}}>
      <h1>Layout Test Content</h1>
    </MyappWeb.Layouts.app>
    """
  end
end
