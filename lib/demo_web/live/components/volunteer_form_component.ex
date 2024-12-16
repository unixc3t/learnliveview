defmodule DemoWeb.VolunteerFormComponent do
  use DemoWeb, :live_component

    alias Demo.Volunteers
    alias Demo.Volunteers.Volunteer

    def mount(socket) do
      changeset = Volunteers.change_volunteer(%Volunteer{})
      {:ok, assign(
        socket,
        form: to_form(changeset)
      )}
    end

  def render(assigns) do
    ~H"""
    <div>
      <.form for={@form} phx-submit="save"  phx-change="validate" phx-target={@myself}>
        <.input type="text"  phx-debounce="blur" field={@form[:name]} placeholder="name..." autocomplete="off" />
        <.input type="text" phx-debounce="blur" field={@form[:phone]} autocomplete="off" />
      <.button>checkout</.button>
      </.form>
    </div>
    """
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
end
