defmodule MyappWeb.PageLive do
  use MyappWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="container">
      <.my_component />
    </div>
    """
  end

  defp my_component(assigns) do
    ~H"""
    <div>My Component</div>
    """
  end
end
