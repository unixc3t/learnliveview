defmodule DemoWeb.SalesLive do
  use DemoWeb, :live_view
  alias Demo.Sales

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    {:ok, assign_status(socket)}
  end


  @impl true
  def handle_info(:tick, socket) do
   {:noreply, assign_status(socket)}
  end

  @impl true
  def handle_event("refresh", _, socket) do
   {:noreply, assign_status(socket)}
  end


  defp assign_status(socket) do
      assign(socket,
        new_orders: Sales.new_orders(),
        sales_amount: Sales.sales_amount(),
        satisfaction: Sales.satisfaction()
      )
  end
end
