defmodule DemoWeb.InfiniteScrollLive do
  use DemoWeb, :live_view

  alias Demo.PizzaOrders
  alias Demo.PizzaOrders.PizzaOrder



  defp load_orders(socket) do
        PizzaOrders.list_pizzaorders(
          page: socket.assigns.page,
          per_page: socket.assigns.per_page
        )
  end

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(page: 1, per_page: 10)
      |> stream_configure(:orders, dom_id: &("#{&1.id}"))



      {:ok, stream(socket, :orders, (load_orders(socket)) )}
  end

  def handle_event("load-more", _, socket) do


   socket =  update(socket, :page, &(&1 + 1))
    orders =
      socket
      |> load_orders()

    # result to map
     # map_order =
     #   orders
     #   |> Enum.map(&%{username: &1.username, id: &1.id, pizaa: &1.pizza} )
      assign(socket, orders: orders)

      {:noreply, stream(socket, :orders, orders)}
  end

end
