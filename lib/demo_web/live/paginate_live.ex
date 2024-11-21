defmodule DemoWeb.PaginateLive do
  use DemoWeb, :live_view
  alias Demo.Donations

  def mount(_params, _session, socket) do
    paginate_options = %{page: 1, per_page: 5}
    donations = Donations.list_donations(paginate: paginate_options)

    socket =
      assign(socket,
        options: paginate_options,
        donations: donations
      )

    {:ok, socket, temporary_assigns: [donations: []]}
  end



  def handle_event("select-per-page", %{"per-page" => per_page }, socket) do
    per_page = String.to_integer(per_page)

    paginate_options = %{page: socket.assigns.options.page, per_page: per_page}
    donations = Donations.list_donations(paginate: paginate_options)

    socket = assign(socket,
    options: paginate_options,
    donations: donations
    )

    socket =
      push_patch(socket, to: "/paginate?page=#{socket.assigns.options.page}&per_page=#{per_page}")

    {:noreply, socket}
  end


  def handle_params(params, _url, socket) do
    page = String.to_integer(params["page"] || "1")
    per_page = String.to_integer(params["per_page"] || "5")

    paginate_options = %{page: page, per_page: per_page}
    donations = Donations.list_donations(paginate: paginate_options)

    socket =
      assign(socket,
        options: paginate_options,
        donations: donations
      )

    {:noreply, socket}
  end


  def expires_class(donation) do
    if Donations.almost_expired?(donation), do: "eat-now", else: "fresh"
  end

  attr :path, :string, required: true
  attr :name, :string, required: true
  attr :page, :string, required: true
  attr :page2, :string
  attr :per_page, :string, required: true
  attr :current_page,  :string

  def link_body(assigns) do
    ~H"""
    <a
      data-phx-link="patch"
      data-phx-link-state="push"
      href={"/#{@path}?page=#{@page}&per_page=#{@per_page}" }
    >
      <%= @name %>
    </a>
    """
  end

  def link_page(assigns) do
    ~H"""
    <a
      data-phx-link="patch"
      data-phx-link-state="push"
      href={"/#{@path}?page=#{@page}&per_page=#{@per_page}" }
      class={if @current_page == @page2, do: "active"}
    >
      <%= @name %>
    </a>
    """
  end
end
