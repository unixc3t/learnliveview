defmodule DemoWeb.ServerLive do
  use DemoWeb, :live_view
  alias Demo.Servers

  def mount(_params, _session, socket) do
    servers = Servers.list_servers()

    socket = assign(
      socket,
      servers: servers,
      selected_server: hd(servers)
    )

    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    id = String.to_integer(id)
    server = Servers.get_server!(id)
    socket = assign(socket, selected_server: server)
    {:noreply, socket}
  end

  def handle_params(_, _uri, socket) do
    {:noreply, socket}
  end

  def handle_event("show", %{"id" => id}, socket) do
    id = String.to_integer(id)
    server = Servers.get_server!(id)
    socket = assign(socket, selected_server: server)
    {:noreply, socket}
  end

  attr :path, :string, required: true
  attr :name, :string, required: true
  attr :key, :string, required: true
  attr :value, :string, required: true
  attr :select_server_name, :any, required: true
  def link_body(assigns) do
    ~H"""
      <a id="ss" data-phx-link="patch" data-phx-link-state="push" href={"/#{@path}?#{@key}=#{@value}"} class={if @name == @select_server_name, do: "active"} >
      <img src="/images/server.svg" style="display: inline-block;"> <%= @name %>
      </a>
    """
  end
end
