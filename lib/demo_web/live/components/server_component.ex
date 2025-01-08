defmodule DemoWeb.ServerComponent do
 use DemoWeb, :live_component

 def render(assigns) do
   ~H"""
    <div id="server-{@server-id}">
      <%= @server.name%> <.link patch={~p"/servers/#{@server}/edit"}>Edit</.link>
    </div>
   """
 end
end
