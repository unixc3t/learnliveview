defmodule DemoWeb.VolunteersLive do
   use DemoWeb, :live_view

   alias Demo.Volunteers
   alias Demo.Volunteers.Volunteer

   def mount(_params, _session, socket) do
      volunteers = Volunteers.list_volunteers()
      changeset = Volunteers.change_volunteer(%Volunteer{})

      socket = assign(
        socket,
        volunteers: volunteers,
        form: to_form(changeset)
      )

      #{:ok, socket}
      {:ok, socket, temporary_assigns: [volunteers: []]}
   end

  #clean the form
   def handle_event("change", %{"volunteer" => params}, socket) do
        changeset = Volunteers.change_volunteer(%Volunteer{}, params)
        socket = assign(socket, form: to_form(changeset))
        {:noreply, socket}
  end

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
    

  def handle_info({:volunteer_created, volunteer}, socket) do
    socket = update(socket, :volunteers, fn volunteers -> [volunteer | volunteers] end)
    {:noreply, socket}
  end

end