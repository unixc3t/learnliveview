defmodule DemoWeb.LightLive do
  use DemoWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, brightness: 10)
    {:ok, socket}
  end

  def handle_event("on", _, socket) do
    {:noreply, assign(socket, brightness: 100)}
  end
  def handle_event("up", _, socket) do
      brightness = socket.assigns.brightness + 10
      socket = assign(socket, :brightness, brightness)
      {:noreply, socket}
  end
  def handle_event("down", _, socket) do
      brightness = socket.assigns.brightness - 10
      socket = assign(socket, :brightness, brightness)
      {:noreply, socket}
  end
  def handle_event("off", _, socket) do
    {:noreply, assign(socket, brightness: 0)}
  end
end
