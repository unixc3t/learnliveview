defmodule DemoWeb.VolunteersLive do
  use DemoWeb, :live_view

  alias Demo.Volunteers
  alias Demo.Volunteers.Volunteer

  def mount(_params, _session, socket) do

    if connected?(socket), do: Volunteers.subscribe()

    volunteers = Volunteers.list_volunteers()
    changeset = Volunteers.change_volunteer(%Volunteer{})

    socket =
      assign(
        socket,
        volunteers: volunteers,
        form: to_form(changeset)
      )

    #{:ok, socket, temporary_assigns: [volunteers: []]}
    {:ok, stream(socket, :volunteers, volunteers)}
  end

  # clean the form
  #  def handle_event("change", %{"volunteer" => params}, socket) do
  #       changeset = Volunteers.change_volunteer(%Volunteer{}, params)
  #       socket = assign(socket, form: to_form(changeset))
  #       {:noreply, socket}
  # end

  def handle_event("save", %{"volunteer" => params}, socket) do
    case Volunteers.create_volunteer(params) do
      {:ok, volunteer} ->
        #  socket = update(socket, :volunteers, fn volunteers -> [volunteer | volunteers] end)
        send(self(), {:volunteer_created, volunteer})
        changeset = Volunteers.change_volunteer(%Volunteer{})
        socket = assign(socket, form: to_form(changeset))
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        socket = assign(socket, form: to_form(changeset))
        {:noreply, socket}
    end
  end

  # add real-time validate and clear the form when submit the form
  def handle_event("validate", %{"volunteer" => params}, socket) do
    changeset =
      %Volunteer{}
      |> Volunteers.change_volunteer(params)
      |> Map.put(:action, :insert)

    socket =
      assign(socket,
        form: to_form(changeset)
      )

    {:noreply, socket}
  end

  def handle_event("toogle-status", %{"id" => id}, socket) do
    volunteer = Volunteers.get_volunteer!(id)
    {:ok, _new_volunteer} = Volunteers.toogle_status_volunteer(volunteer)
    {:noreply, socket}
  end

  def handle_info({:volunteer_created, new_volunteer}, socket) do
    #socket = update(socket, :volunteers, fn volunteers -> [volunteer | volunteers] end)
    {:noreply, stream(socket, :volunteers, [new_volunteer], at: 0 )}

  end
  def handle_info({:volunteer_updated, new_volunteer}, socket) do
    #socket = update(socket, :volunteers, fn volunteers -> [volunteer | volunteers] end)
    {:noreply, stream(socket, :volunteers, [new_volunteer], at: 0 )}

  end
end
