defmodule DemoWeb.LicenseLive do
  use DemoWeb, :live_view
  alias Demo.License
  import Number.Currency

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, seats: 2, amount: License.calculate(2))}
  end

  @impl true
  def handle_event("update", %{"seats" => seats}, socket) do
    seats = String.to_integer(seats)
    socket = assign(socket, seats: seats, amount: License.calculate(seats))
    {:noreply, socket}
  end
end
