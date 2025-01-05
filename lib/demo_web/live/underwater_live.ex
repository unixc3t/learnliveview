defmodule DemoWeb.UnderwaterLive do
  use DemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :id, "modal-id")}
  end
end
