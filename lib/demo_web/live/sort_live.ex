defmodule DemoWeb.SortLive do
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
    sort_by = socket.assigns.options.sort_by
    sort_order = socket.assigns.options.sort_order
    page = socket.assigns.options.page

    socket = assign(socket,
    options: paginate_options,
    donations: donations
    )

    socket =
      push_patch(socket, to: "/sort?sort_by=#{sort_by}&sort_order=#{sort_order}&page=#{page}&per_page=#{per_page}")

    {:noreply, socket}
  end


  def handle_params(params, _url, socket) do
    page = String.to_integer(params["page"] || "1")
    per_page = String.to_integer(params["per_page"] || "5")

    sort_by = (params["sort_by"] || "id") |> String.to_atom()
    sort_order = (params["sort_order"] || "asc") |> String.to_atom()

    paginate_options = %{page: page, per_page: per_page}
    sort_options = %{sort_by: sort_by,  sort_order: sort_order}

    donations = Donations.list_donations(
      paginate: paginate_options,
      sort: sort_options
      )

    socket =
      assign(socket,
        options: Map.merge(paginate_options, sort_options),
        donations: donations
      )

    {:noreply, socket}
  end


   def handle_info({:update, opts}, socket) do

     %{sort_order: sort_order, sort_by: sort_by, page: page, per_page: per_page} = opts


    socket =
      push_patch(socket, to: "/sort?sort_by=#{sort_by}&sort_order=#{sort_order}&page=#{page}&per_page=#{per_page}")

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
  attr :sort_by, :string
  attr :sort_order, :string

  def link_body(assigns) do
    ~H"""
    <a
      data-phx-link="patch"
      data-phx-link-state="push"
      href={"/#{@path}?sort_by=#{@sort_by}&sort_order=#{@sort_order}&page=#{@page}&per_page=#{@per_page}" }
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
      href={"/#{@path}?sort_by=#{@sort_by}&sort_order=#{@sort_order}&page=#{@page}&per_page=#{@per_page}" }
      class={if @current_page == @page2, do: "active"}
    >
      <%= @name %>
    </a>
    """
  end


  def sort_by(assigns) do

    ~H"""
    <a
      data-phx-link="patch"
      data-phx-link-state="push"
      href={"/#{@path}?sort_by=#{@sort_by}&sort_order=#{toggle_sort_order(@sort_order)}&page=#{@page}&per_page=#{@per_page}" }
    >
      <%= @name %>
    </a>
    """
  end

  def sort_by2(assigns) do

    ~H"""
      <.link patch={"/#{@path}?sort_by=#{@sort_by}&sort_order=#{toggle_sort_order(@sort_order)}&page=#{@page}&per_page=#{@per_page}"}  >
        <%= @name %>
      </.link>
    """

  end

  defp toggle_sort_order(:desc), do: :asc
  defp toggle_sort_order(:asc), do: :desc

end
