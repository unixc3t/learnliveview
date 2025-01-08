defmodule DemoWeb.TestComponent do
  use Phoenix.Component

  attr :myrows, :list, required: true

  slot :mycol, required: true do
    attr :label, :string
  end

  def table_1(assigns) do
    ~H"""
    <%= for col <- @mycol do %>
      <%= col.label %>
    <% end %>
        <br/>
    <%= for my <- @myrows  do %>
      <%= for col <- @mycol do %>
        <%= render_slot(col, my) %>
      <% end %>
        <br/>
    <% end %>
    """
  end

  def table_2(assigns) do
    ~H"""
    <%= for col <- @mycol do %>
      <%= col.label %>
    <% end %>
    <.myview myrows={@myrows} mycol={@mycol}></.myview>
    """
  end

  def myview(assigns) do
    ~H"""
    <%= for my <- @myrows  do %>
      <%= for col <- @mycol do %>
        <%= render_slot(col, my) %>
      <% end %>
    <% end %>
    """
  end
end
