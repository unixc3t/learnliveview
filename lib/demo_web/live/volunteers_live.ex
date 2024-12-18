defmodule DemoWeb.VolunteersLive do
  use DemoWeb, :live_view

  alias Demo.Volunteers

  def mount(_params, _session, socket) do

    if connected?(socket), do: Volunteers.subscribe()

    volunteers = Volunteers.list_volunteers()

    socket =
      assign(
        socket,
        recent_activity: nil
      )

    #{:ok, socket, temporary_assigns: [volunteers: []]}
    {:ok, stream(socket, :volunteers, volunteers)}
  end





  def handle_info({:volunteer_created, new_volunteer}, socket) do
    #socket = update(socket, :volunteers, fn volunteers -> [volunteer | volunteers] end)
    {:noreply, stream(socket, :volunteers, [new_volunteer], at: 0 )}

  end
  def handle_info({:volunteer_updated, new_volunteer}, socket) do
    #socket = update(socket, :volunteers, fn volunteers -> [volunteer | volunteers] end)

    socket = assign(
      socket,
      recent_activity: "#{new_volunteer.name} checked #{if new_volunteer.check_out, do: "out", else: "in"}"
    )

    #{:noreply, stream(socket, :volunteers, [new_volunteer], reset: true )}
    {:noreply, stream(socket, :volunteers, [new_volunteer] )}

  end
end
