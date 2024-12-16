defmodule DemoWeb.VolunteerComponent do
 use DemoWeb, :live_component

 alias Demo.Volunteers

 def render(assigns) do
  ~H"""
    <div class={ if @volunteer.check_out, do: "volunteer out", else: "volunteer" }>
        <div class="name">
          <%= @volunteer.name %>
        </div>
        <div class="phone">
          <img src="images/phone.svg" alt="phone">
          <%= @volunteer.phone %>
        </div>
        <div class="status">
          <button phx-click="toogle-status" phx-value-id={@volunteer.id}
          phx-disable-with="Saving..." phx-target={@myself}>
            <%= if @volunteer.check_out, do: "Check In", else: "Check Out" %>
          </button>
        </div>
    </div>
  """
 end

  def handle_event("toogle-status", %{"id" => id}, socket) do
    volunteer = Volunteers.get_volunteer!(id)
    {:ok, _new_volunteer} = Volunteers.toogle_status_volunteer(volunteer)
    {:noreply, socket}
  end
end
