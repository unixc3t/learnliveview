defmodule DemoWeb.FilterLive do
  use DemoWeb, :live_view

  alias Demo.Boats
 #alias Demo.Boats.Boat


 def mount(_params, _session, socket) do
  socket =
    assign(socket,
      boats: Boats.list_boats(),
      type: "sporting",
      prices: []
    )

    {:ok, socket}
 end

 def handle_event("filter", %{"type" => type, "prices" => prices}, socket) do
  params = [type: type, prices: prices]
  boats = Boats.list_boats(params)
  socket = assign(socket, params ++ [boats: boats])
  {:noreply, socket}
 end

  attr :name, :string, required: true
  attr :prices, :list, required: true
  attr :s_prices, :list, required: true, doc: "selected checkbox list"

 def price_checkbox(assigns) do
  assigns = Enum.into(assigns, %{})

   ~H"""
        <input type="hidden" name={@name} value="">
          <%= for price <- @prices do %>
          <span>
          <input type="checkbox" id={price} name={@name} value={price} checked={price in @s_prices}  >
          <label for={price}><%= price %></label>
          </span>
          <% end %>
   """
 end


 defp type_options do
  %{
    Fishing: "fishing",
    Sporting: "sporting",
    Sailing: "sailing",
  }
 end
end
