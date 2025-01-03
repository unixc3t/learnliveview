defmodule DemoWeb.QuoteComponent do
  use DemoWeb, :live_component

  import Number.Currency


  def mount(socket) do
      {:ok, assign(socket, hrs_until_expires: 24)}
  end

  # def update(assigns, socket) do
  #   socket = assign(socket, assigns)
  #   {:ok, socket}
  # end

  def render(assigns) do
    ~H"""
      <div class="text-center p-6 border-4 border-dashed border-indigo-600">
        <h2>
           Our best deal:
        </h2>

        <h3 class="text-xl font-semibold text-indigo-600">
          <%= @weight %> pounds of <%= @material %> for <%= number_to_currency(@price) %>
        </h3>

        <div class="text-gray-600">
          expires in <%= @hrs_until_expires %> hours
        </div>
      </div>
    """
    end
end
