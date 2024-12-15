defmodule DemoWeb.SandboxLive do
  use DemoWeb, :live_view

  alias DemoWeb.SandboxCalculatorComponent
  alias DemoWeb.QuoteComponent

  def mount(_params, _session, socket) do
     {:ok, assign(socket, weight: nil, price: nil, delivery_charge: nil)}
  end

    def handle_info({:totals, weight, price}, socket) do
    socket = assign(socket, weight: weight, price: price)

    {:noreply, socket}
  end

end
