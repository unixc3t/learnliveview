defmodule DemoWeb.SortComponent do
  use DemoWeb, :live_component

  def render(assigns) do
    ~H"""
    <span phx-click="sort_by" phx-target={@myself}>
      <%= @name %> <%= chevron(@sort_by, @sort_order) %>
    </span>
    """
  end

  def handle_event("sort_by", _params, socket) do
    %{sort_order: sort_order, name: sort_by, page: page, per_page: per_page} = socket.assigns
      sort_by = (sort_by || "id") |> String.to_atom()
      sort_order = if sort_order == :asc, do: :desc, else: :asc
    opts = %{sort_by: sort_by, sort_order: sort_order, page: page, per_page: per_page}



    send(self(), {:update, opts})
    {:noreply, socket}
  end



  def chevron(_sort_by, sort_order) do
    if sort_order == :asc, do: "⇧", else: "⇩"
  end

end
