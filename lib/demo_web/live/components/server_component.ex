defmodule DemoWeb.ServerComponent do
  use DemoWeb, :live_component

  alias Demo.Servers
  alias Demo.Servers.Server

  def render(assigns) do
   ~H"""
        <div  >
          <.simple_form
          for={@form}
          id="server-form"
          phx-target={@myself}
          phx-change="validate"
          phx-submit="save">

          <.input field={@form[:name]} type="text" label="Name" />
          <.input field={@form[:size]} type="text" label="size" />
          <.input field={@form[:status]} type="text" label="status" />
          <.input field={@form[:git_repo]} type="text" label="git_repo" />

                <.button>save</.button>

          </.simple_form>
        </div>
   """
  end

    def handle_event("save", %{"server" => server_params}, socket) do
    save_product(socket, server_params)
  end


    def handle_event("validate", %{"server" => params}, socket) do
    changeset =
      %Server{}
      |> Servers.change_server(params)
      |> Map.put(:action, :insert)

    socket =
      assign(socket,
        form: to_form(changeset)
      )

    {:noreply, socket}
  end

  defp save_product(socket, params) do

    case Servers.create_server(params) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
