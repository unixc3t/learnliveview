defmodule DemoWeb.ServerFormComponent do
  use DemoWeb, :live_component

  alias Demo.Servers
  alias Demo.Servers.Server

  def update(%{server: server} = assigns, socket) do
    changeset = Servers.change_server(server)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
      </.header>
      <.simple_form
        for={@form}
        id="server-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:size]} type="text" label="size" />
        <.input field={@form[:status]} type="text" label="status" />
        <.input field={@form[:git_repo]} type="text" label="git_repo" />

        <.button>save</.button>
      </.simple_form>
    </div>
    """
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
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

  def handle_event("save", %{"server" => server_params}, socket) do
    save_product(socket, socket.assigns.action, server_params)
  end

  # send(self(), {:volunteer_created, volunteer})
  # defp notify_parent(msg), do: send(self(), msg)

  def save_product(socket, :edit, params) do
    case Servers.update_server(socket.assigns.server, params) do
      {:ok, server} ->
        send(self(), {:update, server})

        {:noreply,
         socket
         |> put_flash(:info, "Product updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  def save_product(socket, :new, params) do
    case Servers.create_server(params) do
      {:ok, server} ->
        send(self(), {:saved, server})

        {:noreply,
         socket
         |> put_flash(:info, "Product created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  # defp save_product(socket, params) do
  #   case Servers.create_server(params) do
  #     {:ok, _product} ->
  #       {:noreply,
  #        socket
  #        |> put_flash(:info, "Product created successfully")
  #        |> push_patch(to: socket.assigns.patch)}

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       {:noreply, assign_form(socket, changeset)}
  #   end
  # end
end
