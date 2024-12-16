defmodule DemoWeb.HeaderComponent do

  use DemoWeb, :live_component

  def render(assigns) do
    ~H"""
      <div>
      <h1 class="mb-2 text-center text-fuchsia-500 text-2xl"> <%= @title %> </h1>
      <h2 class="text-center text-2xl text-gray-400"><%= @subtitle %></h2>
      </div>
    """
  end
end
